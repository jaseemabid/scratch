import pytest

def test_foo():

    assert 1 == 2

    with pytest.raises(Exception):
        assert 1 == 2

