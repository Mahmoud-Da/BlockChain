pragma solidity ^0.4.11;

contract hadcoin_ico {
    // Maximum number of hadcoins available for sale
    uint public max_hadcoins = 1000000;

    // Conversion rate: 1 USD = 1000 hadcoins
    uint public usd_to_hadcoins = 1000;

    // Total number of hadcoins bought by investors
    uint public total_hadcoins_bought = 0;

    // Mapping from investor address to their equity in AdCoins
    mapping(address => uint) equityAtcoins;

    // Mapping from investor address to their equity in USD
    mapping(address => uint) equityUSD;

    // Modifier to check if an investor can buy AdCoins
    modifier canBuyAdCoins(uint usdInvested) {
        require(
            (usdInvested * usd_to_hadcoins + total_hadcoins_bought) <=
                max_hadcoins
        );
        _;
    }

    // Function to get the equity in AdCoins of an investor
    // Takes the investor's address as input and returns their equity in AdCoins
    function equityInAltCoins(
        address investor
    ) external constant returns (uint) {
        return equityAtcoins[investor];
    }

    // Function to get the equity in USD of an investor
    // Takes the investor's address as input and returns their equity in USD
    function equityInUSD(address investor) external constant returns (uint) {
        return equityUSD[investor];
    }

    // Function to allow an investor to buy AdCoins
    // Updates equity in AdCoins, equity in USD, and total AdCoins bought
    function buyAdCoins(
        address investor,
        uint usdInvested
    ) external canBuyAdCoins(usdInvested) {
        // Calculate number of AdCoins bought for the invested USD
        uint adCoinsBought = usdInvested * usd_to_hadcoins;

        // Update equity in AdCoins for the investor
        equityAtcoins[investor] += adCoinsBought;

        // Update equity in USD for the investor
        equityUSD[investor] = equityAtcoins[investor] / usd_to_hadcoins;

        // Update total AdCoins bought by all investors
        total_hadcoins_bought += adCoinsBought;
    }
}
