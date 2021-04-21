pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Voting is Ownable {

    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
        }

    struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
        }

    struct Proposal {
        string description;
        uint voteCount;
        }

    uint winningProposalId;
    uint winningProposalVotes;
    WorkflowStatus public step = WorkflowStatus.RegisteringVoters;
    mapping(address=>bool) whitelist;
    mapping(address=>Voter) public voters;
    Proposal[] public proposals;

    event VoterRegistered(address voterAddress);
    event ProposalsRegistrationStarted();
    event ProposalsRegistrationEnded();
    event ProposalRegistered(uint proposalId);
    event VotingSessionStarted();
    event VotingSessionEnded();
    event Voted (address voter, uint proposalId);
    event VotesTallied();
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus
    newStatus);

    modifier rightStep(WorkflowStatus _step) {
        require(step == _step);
        _;
    }

    modifier onlyRegistered() {
        require(whitelist[msg.sender] == true);
        _;
    }

    modifier hasNotVoted() {
        require(voters[msg.sender].hasVoted == false);
        _;
    }

    function nextStep() public onlyOwner {
        if(step == WorkflowStatus.RegisteringVoters) {
            step = WorkflowStatus.ProposalsRegistrationStarted;
            emit ProposalsRegistrationStarted();
        }
        else if(step == WorkflowStatus.ProposalsRegistrationStarted) {
            step = WorkflowStatus.ProposalsRegistrationEnded;
            emit ProposalsRegistrationEnded();
        }
        else if(step == WorkflowStatus.ProposalsRegistrationEnded) {
            step = WorkflowStatus.VotingSessionStarted;
            emit VotingSessionStarted();
        }
        else if(step == WorkflowStatus.VotingSessionStarted) {
            step = WorkflowStatus.VotingSessionEnded;
            emit VotingSessionEnded();
        }
        else if(step == WorkflowStatus.VotingSessionEnded) {
            step = WorkflowStatus.VotesTallied;
            emit VotesTallied();
        }
    }

    function registerVoter(address _voter) public onlyOwner rightStep(WorkflowStatus.RegisteringVoters) {
        whitelist[_voter] = true;
        emit VoterRegistered(_voter);
    }

    function registerProposal(string memory _proposal) public onlyRegistered rightStep(WorkflowStatus.ProposalsRegistrationStarted) {
        proposals.push(Proposal(_proposal, 0));
        emit ProposalRegistered(proposals.length);
    }

    function voteProposal(uint _proposalId) public onlyRegistered hasNotVoted rightStep(WorkflowStatus.VotingSessionStarted) {
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedProposalId = _proposalId;

        emit Voted(msg.sender, _proposalId);
        proposals[_proposalId].voteCount++;

        if (proposals[_proposalId].voteCount > winningProposalVotes) {
            winningProposalVotes = proposals[_proposalId].voteCount;
            winningProposalId = _proposalId;
        }
    }

    function getWinningProposalId() public view onlyRegistered rightStep(WorkflowStatus.VotesTallied) returns (uint) {
        return winningProposalId;
    }
}

