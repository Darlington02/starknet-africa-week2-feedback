%lang starknet 

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

// 
// STRUCTS
// 
struct Details {
    name: felt,
    age: felt,
    gender: felt,
}

// 
// STORAGE VARIABLES
// 
@storage_var
func admin_address() -> (address: felt) {
}

@storage_var
func student_details(address: felt) -> (details: Details) {
}

// 
// CONSTRUCTOR
// 
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    admin: felt
) {
    let (address) = get_caller_address();
    admin_address.write(address);

    return ();
}

// EXTERNALS
@external
func store_details{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt, age: felt, gender: felt
) {
    let (student_address) = get_caller_address();
    let student_struct = Details(name, age, gender);
    student_details.write(student_address, student_struct);

    return ();
}

// GETTERS
@view
func get_name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    address: felt
) -> (name: felt) {
    let (details) = student_details.read(address);
    let name = details.name;
    
    return (name=name);
}
