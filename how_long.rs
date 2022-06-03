use std::time::{Duration, SystemTime};
use std::thread::sleep;

fn main() {
    let start = SystemTime::now();
    let mut i = 0;
    loop {
        i += 1;
        if i % 1000000 == 0 {
            println!("{}", i);
        }
        if i == 1000000000 {
            break;
        }
    }
    let end = SystemTime::now();
    let duration = end.duration_since(start).unwrap();
    println!("it took {} sec to reach 1000000000", duration.as_secs());
}
