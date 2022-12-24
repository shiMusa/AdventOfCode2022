using Basic :: #import "Basic";
// #poke_name Basic operator==;
#import "String";
#import "File";
#import "Math";
#import "Sort";

trimmed :: (txt: *string, body: Code, flags: For_Flags) #expand {
    i := 0;
    for l: split(<<txt, "\n") {
        line := trim(l, "\r");
        if !line continue;

        `it := line;
        `it_index := i;
        defer i += 1;

        #insert body;
    }
}

array_find_sorted :: (array: []$T, val: T, $return_closest_previous_index:=false) -> int {
    DEBUG :: false;

    if !array then return -1;

    min := 0;
    max := array.count-1;

    if val < array[min] return -1;
    if val > array[max] return #ifx return_closest_previous_index then max; else -1;

    while true {
        #if DEBUG print("search in (%,%):[%,%]\n", min, max, array[min], array[max]);
        if val == array[min] return min;
        if val == array[max] return max;

        mid := (max+min)/2;
        #if DEBUG print("mid (%)[%]\n", mid, array[mid]);
        if mid == min || mid == max return #ifx return_closest_previous_index min; else -1;

        if val == array[mid] return mid;

        if val < array[mid] then max = mid;
        else                     min = mid;
    }

    assert(false, "cannot be reached");
    return -1;
}

array_insert_sorted :: (array: *[..]$T, val: T, $unique:=false) -> index:int, new_entry:bool {
    DEBUG :: false;

    #if DEBUG print("array_insert_sorted: array %, val %, unique %\n", <<array, val, unique);

    if array.count == 0 {
        #if DEBUG print("empty array, just add first value\n");
        array_add(array, val);
        return 0, true;
    }

    min := 0;
    max := array.count-1;

    if val < array.data[min] {
        array_insert_at(array, val, 0);
        return 0, true;
    }
    if val > array.data[max] {
        array_add(array, val);
        return max, true;
    }

    while true {
        #if DEBUG print("search in (%,%):[%,%]\n", min, max, array.data[min], array.data[max]);
        if val == array.data[min] {
            #if !unique array_insert_at(array, val, min);
            return min, false;
        }
        if val == array.data[max] {
            #if !unique array_insert_at(array, val, max);
            return max, false;
        }

        mid := (max+min)/2;
        #if DEBUG print("mid (%)[%]\n", mid, array.data[mid]);
        if mid == min || mid == max {
            array_insert_at(array, val, mid);
            return mid, true;
        }

        if val == array.data[mid] {
            #if !unique array_insert_at(array, val, mid);
            return mid, true;
        }

        if val < array.data[mid] then max = mid;
        else                          min = mid;
    }

    assert(false, "cannot be reached");
    return -1, false;
}