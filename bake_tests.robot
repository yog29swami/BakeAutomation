*** Settings ***
Documentation     Bake feature tests that run the compiled bake.exe    # what this suite checks
Library           Process    # built-in library for running programs

*** Variables ***
${BAKE_EXE}       C:/CICD-Jenkins-Practice/Bake/bake.exe    # default program path; Jenkins overrides it

*** Test Cases ***
Bake Accepts Valid Temperature
    ${bake_result}=    Run Process    ${BAKE_EXE}    350    # run bake.exe with 350 F
    Should Be Equal As Integers    ${bake_result.rc}    0    # exit code 0 means accepted
    Should Contain    ${bake_result.stdout}    STATE=BAKE TEMPERATURE=350    # oven reports Bake at 350

Bake Rejects Temperature Above Maximum
    ${bake_result}=    Run Process    ${BAKE_EXE}    700    # run bake.exe with 700 F
    Should Be Equal As Integers    ${bake_result.rc}    1    # exit code 1 means rejected
    Should Contain    ${bake_result.stdout}    out of range    # error message is printed

Bake Rejects Temperature Below Minimum
    ${bake_result}=    Run Process    ${BAKE_EXE}    100    # run bake.exe with 100 F
    Should Be Equal As Integers    ${bake_result.rc}    1    # exit code 1 means rejected
