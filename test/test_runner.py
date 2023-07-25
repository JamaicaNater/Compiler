import subprocess
import difflib
import sys

def highlight_differences(original: str, modified: str) -> str:
    matcher = difflib.SequenceMatcher(None, original, modified)

    diff_output = []
    for op, i1, i2, j1, j2 in matcher.get_opcodes():
        if op == 'equal':
            diff_output.append(modified[i1:i2])
        elif op == 'replace':
            diff_output.append(f"\033[91m{modified[i1:i2]}\033[0m")
        elif op == 'delete':
            diff_output.append(f"\033[91m{original[i1:i2]}\033[0m")
        elif op == 'insert':
            diff_output.append(f"\033[92m{modified[j1:j2]}\033[0m")

    return ''.join(diff_output)

def get_expected(file_name: str) -> str:
    with open(file_name, "r") as file:
        expected = file.read()
    return expected.strip('\n')

def get_result(file_name: str) -> str:
    result = subprocess.run(["./obj/mcc", file_name, "asm.asm"], capture_output=True, text=True)
    return result.stdout.strip('\n')

test_cases = {
    "test/cases/testArrayIndex.mC" : "test/expected/testArrayIndex.exp",
    "test/cases/testFuncCallMatch.mC" : "test/expected/testFuncCallMatch.exp",
    "test/cases/testMulDeclFunc.mC" : "test/expected/testMulDeclFunc.exp",
    "test/cases/testMulDeclVars.mC" : "test/expected/testMulDeclVars.exp",
    "test/cases/testTypeMismatch.mC" : "test/expected/testTypeMismatch.exp",
    "test/cases/testUnDeclFunc.mC" : "test/expected/testUnDeclFunc.exp",
    "test/cases/testUnDeclVars.mC" : "test/expected/testUnDeclVars.exp",
}

def main():
    failed_test_cases = []
    subprocess.run(["make"], capture_output=True, text=True)

    for test_case in test_cases.keys():
        expected = get_expected(test_cases[test_case])
        result = get_result(test_case)
        if expected == result: 
            print(f'Test case passed: {test_case}')
        else:
            failed_test_cases.append(test_case)
            highlighted_diff = highlight_differences(expected, result)
            print(highlighted_diff)

    subprocess.run(["make", "clean"], capture_output=True, text=True)

    if not len(failed_test_cases):
        print("Tests passed successfully.")
        sys.exit(0)
    else:
        print("Error: Tests failed.")
        sys.exit(1)

if __name__ == "__main__":
    main()