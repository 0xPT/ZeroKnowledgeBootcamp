// I AM NOT DONE

%lang starknet
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem

// Using binary operations return:
// - 1 when pattern of bits is 01010101 from LSB up to MSB 1, but accounts for trailing zeros
// - 0 otherwise

// 000000101010101 PASS
// 000000010101010 PASS
// 010101010101011 FAIL

// We need to convert "n", the felt to binary
// We need to process 2 bits at a time, and then loop through the next 2 bits until we hit trailing zeros

// How to convert integer to binary
// 170 / 2 = 85, 0
// 85 / 2 = 42, 1
// 42 / 2 = 21, 0
// 21 / 2 = 10, 1
// 10 / 2 = 5, 0
// 5 / 2 = 2, 1
// 2 / 2 = 1, 0
// 1 / 2 = 0, 1

func decimalToBinaryConversion{range_check_ptr}(arr: felt*, idx: felt, prevQ: felt) -> (newArr: felt*, newIdx: felt) {
    if (prevQ == 0) {
        return (arr, idx);
    }

    let (newQ, newR) = unsigned_div_rem(prevQ, 2);

    assert arr[idx] = newR;

    return decimalToBinaryConversion(arr, idx + 1, newQ);
}

func checkOnesAndZeros{}(arr: felt*, flag: felt, arrLength: felt, curIndex: felt) -> felt {
    if (curIndex == arrLength) {
        return (1);
    }

    if ([arr] != flag) {
        return (0);
    }

    return checkOnesAndZeros(arr + 1, 1 - flag, arrLength, curIndex + 1);
}

func pattern{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(
    n: felt, idx: felt, exp: felt, broken_chain: felt
) -> (true: felt) {
    alloc_locals;

    let (array: felt*) = alloc();
    let (binary, binaryIndex) = decimalToBinaryConversion(array, idx, n);
    let result = checkOnesAndZeros(binary, binary[0], binaryIndex, 0);

    // [], 0, 170
    // 

    // local mask = 0x01;
    // bitwise_xor(data, mask) = 0;
    // let (shifted_digit0) = bitwise_and(n, 0x01);
    // tempvar digit0 = shifted_digit0 / 0x01;
    // let (shifted_digit1) = bitwise_and(n, 0x10);
    // tempvar digit1 = shifted_digit1 / 0x10;

    // let lasttwo = bitwise_xor(digit0, digit1);

    return (result,);
}
