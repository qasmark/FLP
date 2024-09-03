import Test.HUnit

test1 = TestCase (assertEqual "for the first Fermat triangle number," 1 (fermatTriangleNumbers !! 0))
test2 = TestCase (assertEqual "for the fifth Fermat triangle number," 15 (fermatTriangleNumbers !! 4))

tests = TestList [TestLabel "Test 1" test1, TestLabel "Test 2" test2]

main = runTestTT tests
