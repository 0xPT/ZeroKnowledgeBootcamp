from starkware.cairo.common.uint256 import Uint256, uint256_add

// Modify both functions so that they increment
// supplied value and return it
func add_one(y: felt) -> (val: felt) {
    let x = y + 1;
    return (x,);
}

func add_one_U256{range_check_ptr}(y: Uint256) -> (val: Uint256) {
    let (x, carry) = uint256_add(y, Uint256(1, 0));
    return (x,);
}
