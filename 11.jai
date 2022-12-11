#import "Basic";
// using Basic :: #import "Basic";
// #poke_name Basic operator==;
#import "String";
#import "File";
#import "Math";

main :: () {
    // part_1(check);
    part_1(check, 10000, true);
}



part_1 :: (input: string, $ROUNDS := 20, $part2 := false) {

    Op :: struct {
        lhs : string;
        op  : string;
        rhs : string;
    }

    items       : [..][..]int;
    ops         : [..]Op;
    test        : [..]int;
    case_true   : [..]int;
    case_false  : [..]int;
    inspections : [..]int;

    i := 0;
    for split(input, "\n") {
        line := trim(it, " \r");
        if !line continue;
        print("%\n", line);

        words := split(line, " ");

        mk := items.count-1;

        // parse input
        if words[0] == {
            case "Monkey";
                arr : [..]int;
                array_add(*items, arr);
                array_add(*ops, Op.{});
                array_add(*test, -1);
                array_add(*case_true, -1);
                array_add(*case_false, -1);
                array_add(*inspections, 0);
            case "Starting";
                for w: 2..words.count-1 {
                    num := trim(words[w], ",");
                    array_add(*items[mk], parse_int(*num));
                }
            case "Operation:";
                ops[mk].lhs = words[3];
                ops[mk].op  = words[4];
                ops[mk].rhs = words[5];
            case "Test:";
                test[mk] = parse_int(*words[3]);
            case "If";
                if words[1] == "true:"  case_true[mk]  = parse_int(*words[5]);
                if words[1] == "false:" case_false[mk] = parse_int(*words[5]);
        }
    }

    print("items      : %\n", items);
    print("ops        : %\n", ops);
    print("test       : %\n", test);
    print("case_true  : %\n", case_true);
    print("case_false : %\n", case_false);

    total_test : int = 1;
    for test total_test *= it;

    eval :: (monkey: int) #expand {
        l : int = ---;
        r : int = ---;

        for *items[monkey] {
            if ops[monkey].lhs == {
                case "old"; l = <<it;
                case; l = parse_int(*copy_string(ops[monkey].lhs));
            }
            if ops[monkey].rhs == {
                case "old"; r = <<it;
                case; r = parse_int(*copy_string(ops[monkey].rhs));
            }

            // print("eval(%) : % % %\n", monkey, l, ops[monkey].op, r);

            if ops[monkey].op == {
                case "+"; <<it = l + r;
                case "*"; <<it = l * r;
            }

            inspections[monkey] += 1;
        }
    }
    relax :: (monkey: int) #expand {
        #if !part2 {
            for *items[monkey] {
                <<it /= 3;
            }
        } else {
            for *items[monkey] {
                <<it %= total_test;
            }
        }
    }
    pass_on :: (monkey: int) #expand {
        while items[monkey] {
            it := items[monkey][0];
            array_ordered_remove_by_index(*items[monkey], 0);

            if it % test[monkey] == 0
                array_add(*items[case_true[monkey]], it);
            else
                array_add(*items[case_false[monkey]], it);
        }
    }

    monkeys := items.count;
    for 0..ROUNDS-1 {
        if it == 1 || it == 20 || it % 1000 == 0
            print("after round % : %\n", it, inspections);

        for m: 0..monkeys-1 {
            eval(m);
            relax(m);
            pass_on(m);
            // print("after monkey % : %\n", m, items);
        }
        // print("after round % : %\n", it, items);
    }

    print("inspections : %\n", inspections);
    max_0 := 0;
    max_1 := 0;
    for inspections {
        if max_0 < max_1 {
            if it > max_0 then max_0 = it;
        } else {
            if it > max_1 then max_1 = it;
        }
    }
    print("monkey buisiness : % * % = %\n", max_0, max_1, max_0 * max_1);
}

test :: #string DONE
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
DONE

check :: #string DONE
Monkey 0:
  Starting items: 54, 53
  Operation: new = old * 3
  Test: divisible by 2
    If true: throw to monkey 2
    If false: throw to monkey 6

Monkey 1:
  Starting items: 95, 88, 75, 81, 91, 67, 65, 84
  Operation: new = old * 11
  Test: divisible by 7
    If true: throw to monkey 3
    If false: throw to monkey 4

Monkey 2:
  Starting items: 76, 81, 50, 93, 96, 81, 83
  Operation: new = old + 6
  Test: divisible by 3
    If true: throw to monkey 5
    If false: throw to monkey 1

Monkey 3:
  Starting items: 83, 85, 85, 63
  Operation: new = old + 4
  Test: divisible by 11
    If true: throw to monkey 7
    If false: throw to monkey 4

Monkey 4:
  Starting items: 85, 52, 64
  Operation: new = old + 8
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 7

Monkey 5:
  Starting items: 57
  Operation: new = old + 2
  Test: divisible by 5
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 6:
  Starting items: 60, 95, 76, 66, 91
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 2
    If false: throw to monkey 5

Monkey 7:
  Starting items: 65, 84, 76, 72, 79, 65
  Operation: new = old + 5
  Test: divisible by 19
    If true: throw to monkey 6
    If false: throw to monkey 0
DONE