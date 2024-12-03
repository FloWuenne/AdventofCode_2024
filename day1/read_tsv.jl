function process_columns(filepath::String)
    # Initialize empty vectors to store the columns
    column1 = Int[]
    column2 = Int[]
    
    # Open and read the file line by line
    open(filepath, "r") do file
        for line in eachline(file)
            # Skip empty lines
            isempty(strip(line)) && continue
            
            # Split each line by whitespace
            fields = split(line)
            
            # Check if line has exactly 2 columns
            if length(fields) == 2
                push!(column1, parse(Int, fields[1]))
                push!(column2, parse(Int, fields[2]))
            else
                @warn "Skipping malformed line: '$line' (found $(length(fields)) fields, expected 2)"
            end
        end
    end
    
    # Sort columns independently
    sorted_col1 = sort(column1)
    sorted_col2 = sort(column2)
    
    # Calculate absolute differences between sorted columns
    differences = abs.(sorted_col1 .- sorted_col2)
    
    # Write results to output file
    open("output.txt", "w") do file
        println(file, "Sorted_Col1\tSorted_Col2\tAbs_Difference")
        for (a, b, d) in zip(sorted_col1, sorted_col2, differences)
            println(file, "$a\t$b\t$d")
        end
    end
    
    # Calculate sum of absolute differences
    total_difference = sum(differences)
    
    # New calculation
    unique_col1 = unique(column1)
    weighted_sum = 0
    
    for num in unique_col1
        occurrences = count(==(num), column2)
        weighted_sum += num * occurrences
    end
    
    # Write additional results to console
    println("Sum of (col1 numbers × their frequency in col2): ", weighted_sum)
    
    return sorted_col1, sorted_col2, differences, total_difference, weighted_sum
end

if abspath(PROGRAM_FILE) == @__FILE__
    sorted1, sorted2, diffs, total, weighted_sum = process_columns("input.txt")
    println("Total difference: ", total)
    println("Sum of (col1 numbers × their frequency in col2): ", weighted_sum)
    println("Results have been written to output.txt")
end