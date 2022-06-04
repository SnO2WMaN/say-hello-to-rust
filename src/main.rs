use rand::Rng;
use std::{cmp::Ordering, io};

fn main() {
    let secret: i32 = rand::thread_rng().gen_range(1..=100);
    println!("secret: {}", secret);

    loop {
        println!("input?:");

        let mut guess = String::new();
        io::stdin().read_line(&mut guess).expect("Cannot read line");

        let guess = match guess.trim().parse::<i32>() {
            Ok(n) => n,
            Err(_) => continue,
        };

        println!("answer: {}", guess);

        match guess.cmp(&secret) {
            Ordering::Less => println!("too small"),
            Ordering::Greater => println!("too big"),
            Ordering::Equal => {
                println!("equal");
                break;
            }
        }
    }
}
