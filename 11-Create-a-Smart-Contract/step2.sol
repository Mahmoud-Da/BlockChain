pragma solidity ^0.4.11;

contract hadcoin_ico {
    // Maximum number of hadcoins available for sale
    uint public max_hadcoins = 1000000;

    // Conversion rate: 1 USD = 1000 hadcoins
    uint public usd_to_hadcoins = 1000;

    // Total number of hadcoins bought by investors
    uint public total_hadcoins_bought = 0;
}
