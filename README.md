# Commit - Reveal Scheme with ECVerify

Utilize the ECVerify library to verify signatures on messages easily. 

## Install

`npm install`

## Run Tests

`npm run test`

## This is beautiful

```solidity
require(
    prefixed(commitment).ecverify(sig, msg.sender), 
    "Invalid signature"
);
```

