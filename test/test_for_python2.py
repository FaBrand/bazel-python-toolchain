import sys
import unittest


class PythonVersionTest(unittest.TestCase):
    """Tests for python2 being used"""

    def test_test_for_python2(self):
        self.assertEqual(2, sys.version_info.major)


if __name__ == "__main__":
    unittest.main()
