from starkware.cairo.common.math import unsigned_div_rem

// Perform and log output of simple arithmetic operations
func simple_math{range_check_ptr}() {
   // adding 13 +  14
    alloc_locals;
    local add = 13 + 14;

    %{ print(f"expected 27: {ids.add}") %}

   // multiplying 3 * 6
   local mult = 3 * 6;

   %{ print(f"expected 18: {ids.mult}") %}

   // dividing 6 by 2
   local div1 = 6 / 2;

    %{ print(f"expected 3: {ids.div1}") %}

   // dividing 70 by 2
    local div2 = 70 / 2;
    
     %{ print(f"expected 35: {ids.div2}") %}

   // dividing 7 by 2
    let (local div3, _) = unsigned_div_rem(7, 2);

    %{ print(f"expected 3: {ids.div3}") %}

    return ();
}
