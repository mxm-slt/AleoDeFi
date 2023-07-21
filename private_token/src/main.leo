program private_token.aleo {

    record token {
        // The token owner.
        owner: address,
        // The token amount.
        amount: u64,
    }

    /* Mint */
    // The function `mint` initializes a new record with the specified amount of tokens for the receiver.
    transition mint(receiver: address, amount: u64) -> token {
        return token {
            owner: receiver,
            amount: amount,
        };
    }

    /* Transfer */

    // The function `transfer` sends the specified token amount to the token receiver from the specified token record.
    transition transfer(sender: token, receiver: address, amount: u64) -> (token, token) {
        // Checks the given token record has sufficient balance.
        // This `sub` operation is safe, and the proof will fail if an overflow occurs.
        // `difference` holds the change amount to be returned to sender.
        let difference: u64 = sender.amount - amount;

        // Produce a token record with the change amount for the sender.
        let remaining: token = token {
            owner: sender.owner,
            amount: difference,
        };

        // Produce a token record for the specified receiver.
        let transferred: token = token {
            owner: receiver,
            amount: amount,
        };

        // Output the sender's change record and the receiver's record.
        return (remaining, transferred);
    }

}