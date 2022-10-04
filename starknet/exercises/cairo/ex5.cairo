// Implement a funcion that returns:
// - 1 when magnitudes of inputs are equal
// - 0 otherwise
func abs_eq(x: felt, y: felt) -> (bit: felt) {

    // -2^2=4 is the same as 2^2=4 ( gives abs value )
    if (x*x == y*y) {
        return (1,);
    }
    
    return (0,);
}
