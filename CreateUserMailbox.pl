#!/usr/bin/perl

use strict;
use CLI;

# ARGS[0-4]:  domain pass4server newusername pass4user realnameuser

# variables for connection to server
my $CGServerAddress = 'mail.'.$ARGV[0]; 
my $Domain = $ARGV[0]; 
my $Login = 'postmaster@'.$ARGV[0]; 
my $Password4server = $ARGV[1]; 

# variables new mailboxe's
my $Account = $ARGV[3];
my $RealName = $ARGV[5];
my $Password4user = $ARGV[4];
my $UserData;
  @$UserData{'RealName'}=$RealName;
  @$UserData{'Password'}=$Password4user;

# connection to server
my $cli = new CGP::CLI( { PeerAddr => $CGServerAddress,
                          PeerPort => 106,
                          login    => $Login,
                          password => $Password4server,
                          SecureLogin => 1,
                          SSLTransport => 1 } )
   || die "Can't login to CGPro: ".$CGP::ERR_STRING."\n";

# check duplicate account
my $accountList = $cli->ListAccounts($Domain);
die "\nError " . $cli->getErrMessage . "(".$cli->getErrCode.
    ") fetching accounts list\n"
    unless ($accountList);

my $userName;
foreach $userName (sort keys %$accountList) {
  if ($userName eq $Account) { 
    print "duplicate account\n";
    exit;
  }
}

#  Create new Account
if($cli->CreateAccount(accountName => $Account, settings => $UserData)) {
    print "Created Username = $Account";
} 
else {
    errormsg("Can't create '$Account' account: ".$cli->getErrMessage);
    last MAIN;
}

$cli->Logout; 