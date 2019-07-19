pragma solidity ^0.5.4;
import "../wallet/BaseWallet.sol";

/**
 * @title Interface for a contract that can invest tokens in order to earn an interest.
 * @author Julien Niset - <julien@argent.xyz>
 */
interface Invest {

    event InvestmentAdded(address indexed _wallet, address _token, uint256 _invested, uint256 _period);
    event InvestmentRemoved(address indexed _wallet, address _token, uint256 _fraction);

    /**
     * @dev Invest tokens for a given period.
     * @param _wallet The target wallet.
     * @param _token The token address.
     * @param _amount The amount of tokens to invest.
     * @param _period The period over which the tokens may be locked in the investment (optional).
     * @param _oracles (optional) The address of one or more oracles contracts that may be used by the provider to query information on-chain.
     * @return The exact amount of tokens that have been invested. 
     */
    function addInvestment(
        BaseWallet _wallet, 
        address _token, 
        uint256 _amount, 
        uint256 _period, 
        address[] calldata _oracles
    ) 
        external
        returns (uint256 _invested);

    /**
     * @dev Exit invested postions.
     * @param _wallet The target wallet.
     * @param _token The token address.
     * @param _fraction The fraction of invested tokens to exit in per 10000. 
     * @param _oracles (optional) The address of one or more oracles contracts that may be used by the provider to query information on-chain.
     */
    function removeInvestment(
        BaseWallet _wallet, 
        address _token, 
        uint256 _fraction, 
        address[] calldata _oracles
    ) 
        external;

    /**
     * @dev Get the amount of investment in a given token.
     * @param _wallet The target wallet.
     * @param _token The token address.
     * @param _oracles (optional) The address of one or more oracles contracts that may be used by the provider to query information on-chain.
     * @return The value in tokens of the investment (including interests) and the time at which the investment can be removed.
     */
    function getInvestment(
        BaseWallet _wallet,
        address _token,
        address[] calldata _oracles
    )
        external
        view
        returns (uint256 _tokenValue, uint256 _periodEnd);
}