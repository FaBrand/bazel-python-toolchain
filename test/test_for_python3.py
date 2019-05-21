import sys
import unittest


class PythonVersionTest(unittest.TestCase):
    """Tests for python3 being used"""

    def test_test_for_python3(self):
        self.assertEqual(3, sys.version_info.major)


if __name__ == "__main__":
    unittest.main()
