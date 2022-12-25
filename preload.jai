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


FindClosest :: enum u8 {
    NONE;
    PREVIOUS;
    NEXT;
}

array_find_sorted :: (array: []$T, val: T, $closest:=FindClosest.NONE) -> index: int, found: bool {
    DEBUG :: false;

    if !array then return -1, false;

    min := 0;
    max := array.count-1;

    if val < array[min] #if closest == .NEXT     { return   0, false; } else { return -1, false; };
    if val > array[max] #if closest == .PREVIOUS { return max, false; } else { return -1, false; };

    while true {
        #if DEBUG print("search in (%,%):[%,%]\n", min, max, array[min], array[max]);
        if val == array[min] return min, true;
        if val == array[max] return max, true;

        mid := (max+min)/2;
        #if DEBUG print("mid (%)[%]\n", mid, array[mid    ]);
        if mid == min || mid == max {
            #if closest == .PREVIOUS  return min, false;
            else #if closest == .NEXT return max, false;
            else                      return  -1, false;
        }

        if val == array[mid] return mid, true;

        if val < array[mid] then max = mid;
        else                     min = mid;
    }

    assert(false, "cannot be reached");
    return -1, false;
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
        return max+1, true;
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
        
        if val == array.data[mid] {
            #if !unique array_insert_at(array, val, mid);
            return mid, true;
        }
        
        if mid == min {
            array_insert_at(array, val, min+1);
            return min+1, true;
        }

        if val < array.data[mid] then max = mid;
        else                          min = mid;
    }

    assert(false, "cannot be reached");
    return -1, false;
}