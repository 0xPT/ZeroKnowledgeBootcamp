from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

// Implement a function that sums even numbers from the provided array
func sum_even{bitwise_ptr: BitwiseBuiltin*}(arr_len: felt, arr: felt*, run: felt, idx: felt) -> (
    sum: felt
) {
    // alloc_locals lets you reuse variable names for reassignment
    alloc_locals;
    %{ print(f"--arr_len: {ids.arr_len}") %}

    // If the index is equal to the array length, break the recursive loop
    if (idx == arr_len) {
        return (sum=new_sum,);
    }

    // Call the function recursively with the next index
    //    let (sum) = sum_even(arr_len = arr_len-1, arr, run=run, idx=idx);
    
    let (new_sum) = sum_even(arr_len = arr_len, arr=arr, run=run, idx=idx + 1);

    //let new_sum = sum + [arr];
    let (result) = bitwise_xor([arr],1);
 
    if (result == [arr]+1) {
       let new_local_sum = new_sum + [arr];

        return (sum=new_local_sum,);
    }

    return (sum=new_sum, );
}