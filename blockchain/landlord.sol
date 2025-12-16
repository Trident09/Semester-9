// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HouseRental {
    
    struct RentalAgreement {
        address landlord;
        address tenant;
        uint256 monthlyRent;
        uint256 securityDeposit;
        uint256 agreementStart;
        uint256 agreementEnd;
        bool isActive;
        uint256 lastPaymentDate;
    }
    
    mapping(uint256 => RentalAgreement) public agreements;
    uint256 public agreementCounter;
    
    event AgreementCreated(uint256 indexed agreementId, 
                          address landlord, address tenant);
    event RentPaid(uint256 indexed agreementId, uint256 amount);
    event AgreementTerminated(uint256 indexed agreementId);
    
    function createAgreement(
        address _tenant,
        uint256 _monthlyRent,
        uint256 _securityDeposit,
        uint256 _durationMonths
    ) public payable {
        require(msg.value == _securityDeposit, "Send security deposit");
        require(_tenant != address(0), "Invalid tenant");
        require(_tenant != msg.sender, "Cannot rent to self");
        
        agreementCounter++;
        
        agreements[agreementCounter] = RentalAgreement({
            landlord: msg.sender,
            tenant: _tenant,
            monthlyRent: _monthlyRent,
            securityDeposit: _securityDeposit,
            agreementStart: block.timestamp,
            agreementEnd: block.timestamp + (_durationMonths * 30 days),
            isActive: true,
            lastPaymentDate: block.timestamp
        });
        
        emit AgreementCreated(agreementCounter, msg.sender, _tenant);
    }
    
    function payRent(uint256 _agreementId) public payable {
        RentalAgreement storage agreement = agreements[_agreementId];
        
        require(agreement.isActive, "Agreement not active");
        require(msg.sender == agreement.tenant, "Only tenant can pay");
        require(msg.value == agreement.monthlyRent, "Incorrect amount");
        require(block.timestamp <= agreement.agreementEnd, 
                "Agreement expired");
        
        // Transfer rent to landlord
        payable(agreement.landlord).transfer(msg.value);
        agreement.lastPaymentDate = block.timestamp;
        
        emit RentPaid(_agreementId, msg.value);
    }
    
    function terminateAgreement(uint256 _agreementId) public {
        RentalAgreement storage agreement = agreements[_agreementId];
        
        require(agreement.isActive, "Already terminated");
        require(msg.sender == agreement.landlord || 
                msg.sender == agreement.tenant, "Unauthorized");
        
        // Return security deposit to tenant
        payable(agreement.tenant).transfer(agreement.securityDeposit);
        agreement.isActive = false;
        
        emit AgreementTerminated(_agreementId);
    }
    
    function getAgreementDetails(uint256 _agreementId) 
        public view returns (
            address landlord,
            address tenant,
            uint256 monthlyRent,
            uint256 securityDeposit,
            bool isActive
        ) 
    {
        RentalAgreement memory agreement = agreements[_agreementId];
        return (
            agreement.landlord,
            agreement.tenant,
            agreement.monthlyRent,
            agreement.securityDeposit,
            agreement.isActive
        );
    }
    
    function isRentDue(uint256 _agreementId) 
        public view returns (bool) 
    {
        RentalAgreement memory agreement = agreements[_agreementId];
        
        if (!agreement.isActive) return false;
        
        uint256 timeSinceLastPayment = 
            block.timestamp - agreement.lastPaymentDate;
        
        return timeSinceLastPayment >= 30 days;
    }
}