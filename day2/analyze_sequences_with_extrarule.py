def is_safe_sequence(numbers):
    # Check if sequence is strictly increasing or decreasing
    is_increasing = all(numbers[i] <= numbers[i+1] for i in range(len(numbers)-1))
    is_decreasing = all(numbers[i] >= numbers[i+1] for i in range(len(numbers)-1))
    
    # Check differences between adjacent numbers
    differences = [abs(numbers[i+1] - numbers[i]) for i in range(len(numbers)-1)]
    valid_differences = all(0 < diff <= 3 for diff in differences)
    
    # Line is safe if it's either increasing or decreasing AND has valid differences
    return (is_increasing or is_decreasing) and valid_differences

def can_be_safe_with_removal(numbers):
    # If already safe, return True
    if is_safe_sequence(numbers):
        return True
        
    # Try removing each number one at a time
    for i in range(len(numbers)):
        # Create new list without the current number
        test_sequence = numbers[:i] + numbers[i+1:]
        if is_safe_sequence(test_sequence):
            return True
            
    return False

def analyze_file(filename):
    safe_count = 0
    unsafe_count = 0
    
    with open(filename, 'r') as file:
        for line in file:
            # Convert line to list of integers
            numbers = [int(x) for x in line.strip().split()]
            
            if can_be_safe_with_removal(numbers):
                safe_count += 1
            else:
                unsafe_count += 1
    
    return safe_count, unsafe_count

if __name__ == "__main__":
    # Run the analysis
    safe_lines, unsafe_lines = analyze_file('./input.txt')

    print(f"Analysis Results:")
    print(f"Safe sequences: {safe_lines}")
    print(f"Unsafe sequences: {unsafe_lines}")
    print(f"Total lines: {safe_lines + unsafe_lines}") 