#import "Basic";
#import "String";
#import "File";

main :: () {
    part(test);
}

part :: ($input: string) {
    lines :: #run split(input, "\n");
    rows :: lines.count - 1; // \r
    cols :: lines[0].count - 1; // last line empty
    print("grid % x %\n", rows, cols);

    // grid : [rows][cols]int;
    // for r: 0..rows-1 for c: 0..cols-1 {
    //     grid[r][c] = parse_int(lines[r][c])
    // }

    down  :: 1 << 0;
    up    :: 1 << 1;
    left  :: 1 << 2;
    right :: 1 << 3;

    visible : [rows][cols]u8;
    rmax : [cols]u8;
    cmax : [rows]u8;

    // scan down
    print("scan down\n");
    for r: 0..rows-1 for c: 0..cols-1 {
        print("(%,%)\n", r, c);
        if r == 0 {
            visible[r][c] |= down;
            rmax[c] = lines[r][c];
            continue;
        }

        if rmax[c] < lines[r][c] {
            visible[r][c] |= down;
            rmax[c] = lines[r][c];
        }
    }

    // scan up
    print("scan up\n");
    for <r: rows-1..0 for c: 0..cols-1 {
        print("(%,%)\n", r, c);
        if r == rows-1 {
            visible[r][c] |= up;
            rmax[c] = lines[r][c];
            continue;
        }

        if rmax[c] < lines[r][c] {
            visible[r][c] |= up;
            rmax[c] = lines[r][c];
        }
    }

    // scan right
    print("scan right\n");
    for c: 0..cols-1 for r: 0..rows-1 {
        print("(%,%)\n", r, c);
        if c == 0 {
            visible[r][c] |= right;
            cmax[r] = lines[r][c];
            continue;
        }

        if cmax[r] < lines[r][c] {
            visible[r][c] |= right;
            cmax[r] = lines[r][c];
        }
    }

    // scan left
    print("scan left\n");
    for <c: cols-1..0 for r: 0..rows-1 {
        print("(%,%)\n", r, c);
        if c == cols-1 {
            visible[r][c] |= left;
            cmax[r] = lines[r][c];
            continue;
        }

        if cmax[r] < lines[r][c] {
            visible[r][c] |= left;
            cmax[r] = lines[r][c];
        }
    }

    for r: 0..rows-1 {
        for c: 0..cols-1 
            print("% ", formatInt(visible[r][c], base=2, minimum_digits=4));
        print("\n");
    }

    // count
    total_visible := 0;
    for r: 0..rows-1 for c: 0..cols-1
        if visible[r][c] then total_visible += 1;

    print("visible : %\n", total_visible);
}

test :: #string DONE
30373
25512
65332
33549
35390
DONE