# Detecting allied actions

It'd be nice to be able to detect when allies do certain things as well as detecting which keys J4 presses. For this reason we need to analyse the packets produced by the LoL client and detect them with AHK or similar. For this reason we shall use WireShark / Microsoft Network Monitoring tool. Disclaimer: Specifically we want to detect >ALLIED< Actions. It might also be nice to detect chases and ganks, to an extent, as these can create some nice events for our voice pack.

On Mac:

```lsof``` can be used to give us some information about data flowing in and out of network ports and processes and files accessed by users. We can filter these with Grep e.g. ``` lsof -u Sancarn | Grep -e ".*League.*" ``` will get all processes currently being accessed by sancarn which contain the word "League". Note the pattern here is RegEx.
