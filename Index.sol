// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract HotelRoom {
    enum Statuses { Vacant, Occupied }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhenVacant {
        // Check status
        require( currentStatus == Statuses.Vacant, "Currently Occupied!" );
        _;
    }

    modifier costs(uint _amount) {
        // Check price
        require(msg.value >= _amount, "Not Enough Ether Provided!");
        _;
    }

    function book() payable onlyWhenVacant costs( 2 ether) public {
        currentStatus = Statuses.Occupied;
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);

        emit Occupy(msg.sender, msg.value);
    }
}