#import "Basic";
#import "String";


// #run main();
main :: () {
    // part1(check);
    part2(check);
}


part2 :: (input: string) {
    A :: #char "A";
    a :: #char "a";
    res := 0;
    checks : [52]u8 = ---;

    for split(input, "\n") {
        if it.count == 0 continue;

        // * reset checks array
        if it_index % 3 == 0
            for *c: checks { <<c = 1; };

        line := slice(it, 0, it.count-1);

        for i: 0..line.count-1 {
            c := line.data[i];
            if c <= 90 then c = c - A + 26;
            else            c = c - a;

            if it_index % 3 == 0 && checks[c] % 2 != 0 then checks[c] *= 2;
            if it_index % 3 == 1 && checks[c] % 3 != 0 then checks[c] *= 3;
            if it_index % 3 == 2 && checks[c] % 5 != 0 then checks[c] *= 5;
        }

        for c, i: checks
            if c % (2*3*5) == 0 then res += i + 1;
    }

    print("res = %\n", res);
}


test2 :: #string DONE
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
DONE

test3 :: #string DONE
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
DONE


part1 :: ($input: string) {
    print("part 1 ------------------------------------------\n");
    tmp :: "azAZ";
    A :: #char "A";
    a :: #char "a";
    print("a = %, z = %, A = %, Z = %\n", tmp.data[0], tmp.data[1], tmp.data[2], tmp.data[3]);
    

    print("input = \n");
    print(input);

    res := 0;

    for split(input, "\n") {
        if it.count == 0 continue;
        n := it.count - 1;
        left  := slice(it, 0  , n/2);
        right := slice(it, n/2, n/2);

        print("left  = % \n", left);
        print("right = % \n", right);


        found : [52]bool;
        for i: 0..left.count-1 {
            c := left.data[i];
            // print("c = ");
            // print_character(c);
            // print(" = %", c);
            if c <= 90 then c = c - A + 26;
            else            c = c - a;
            // print(" > %\n", c);
            found[c] = true;
        }

        for i: 0..right.count-1 {
            c := right.data[i];
            tmp := c;
            if c <= 90 then c = c - A + 26;
            else            c = c - a;

            if found[c] {
                found[c] = false;
                print("found ");
                print_character(tmp);
                print(" = % > %\n", c, c+1);

                res += c + 1;
            }
        }
    }

    print("res = %\n", res);
}


test :: #string DONE
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
DONE

check :: #string DONE
lvcNpRHDCnTLCJlL
RFZggsMrjTFGCJmdmd
srsBZgBqwBqRZbzqtHpzzDNtHDqV
CCTPpCvlpzzZQQQflrzbQDttTJcgcggJcHtcddtdhT
nMLBRnGsFFLznRFRLMMNBnNLDRDdhScJccctdSccJJgDDHhH
GVBGVBsLjsrrvfzpjpfQ
dzVRSPVVBVDSPzDBQVSQFFlrclMplpMJMtPJlJvHZCMt
TjmGmbhjTnTmwhmrvvrHcZvCHZMl
fnLwwqfwfqjghHwGThwfTGGBFVDFFsszSRVzRBsdBDgFsV
CCWFCcdDWwcWFpSvggnzRRQszngJwT
mGtqqLrqfmmLNtNrgTjgJzNQlvJTvznJ
tnhVbhMLLZZrnWHPSHDBWbWBFd
nQhvgnCQjSSSTTSMCsLDsfPfDlsPJMWLzL
qrqBFFBbrVRLszLfsqdqPW
bNFFRbBcFZNrZRRRbprNpFrHSwznTnvSwgHvzCSSSjnCQwgz
tnnZZVmwmqtvVdZqnddQQHHTHQLsFTnsPrrgrQ
MzMflMGpzGzPGPgjLgHrGj
zPfhMJDDMJfzlhcRJvVwcVtwVcmcbqqtbv
GVzrBVcPVfGrzVVBcQJlGGRCZSSRtSdRnGLJ
wbjvHWbLvhFppjZdtwZRNddtJwlR
pvMmbpFFbqqqvWHMFvzrLDMMrMTTrVTPzVzc
qPmgpmwpwqWWPHdjdTNStzNLMztSWtMNtz
lVFfJrFJbbcsvcRVRZzQCzQNSZTZ
DGbvFSDGbDjnqgjwmGdq
DMnpnpwwnpmRRmcRBDnDwpbRQHssHqhHCHHSsQddHZQQcqqs
JlZjjlJgNSddfsgQdf
GvrWvzNjvPVLDpbPZwBP
drQDzHsHrdZWqDSSPwmmJDDbvbSJ
hphBhCMFlBtBtGTJMJsscPwTjMJv
tlBCGFgVFNpGClFFVGGtFBZrdZQznfdQQrRWVRQdRsVf
NjdCLdjzzlNdjwBBtZqpqPJQbN
CsDWcHcGHtcBbJPpbP
mGHSssSgSsHFSgGrSgmlLzCdldllrCVCLdnfnT
rDLLzRmbcLJRtRSvSBdZtSTp
MFswshwgsCsjghgFBsGssjlZpfpvdSHfTdCZTSpHtfddTH
llwlwGjMPMQQnBMswsFgglPVcWcDcbWqLWbbLJVDzrqnVr
pqmmcSTLfSSSMFlf
rHWtPWnHtlrlDntzWwtBFdzCFMRCfjRQFfgMRMjC
PWWHDVZPDDJVlWHncGGbqqTVvVmpGTmm
wLBtWhGWJBdMmZMs
jgvNCFvvGppGnmNJ
DDRQTgcvjTPFqGHhRVhLRSVL
tPPwLpBpDpgLSPvgQCvsLPjdjNZrJZsdZjsrsnZNjbZc
lMWzWMBhmMhRGfVRffHmMjJcJjrNNZnjJcWjNqJnZJ
mFMzhTmBGfHTwgPgtptFpPgP
qCcqJQHslgtsQsCZmPWNSRNZTPBBCN
nnLpjjnvwwvDnrGwFvbFjwPgPWRTPrrPShNhmmNSRRPN
bnwdDLjnzGgvFqdJQcqVfQVqHt
DfCzDCCTDLDBCsdjzwdrHjbRgjGH
MSStMScccJtPptJNJZtJJSrFdwPGjFFHHwsggrwdwRdP
nStlpVlhhNSshZlcNZnMcctpBChWBQLqCWqmqvmBCBmQBqmL
RfLHNvfLfLZQBtRZsBfffjVqGvqpGSmJpgrJpjGjrp
FDbPCMzbTTDDPmzrVzqppJBrBj
DPcWPWDhlbCcWBsQZZfHtdwf
fbHfPfHHfPZWgZfSGpqNBqdBBjpjdPBJqv
rnVNCwwrhhDrmmvcmjdDqcmB
hFRrslFRNhFzVthllRCRCCwnQtSGfQgZZbbSWQLSSTZWbQTt
nmVqTFCmTVbnvVCnqwFrffjhZLffhNrNJF
StBHWDgMBpHMBHDzLjffjWwZJNNfNZjL
wBBcDcgzdVbbQcnQlq
MfGCtqGDhjDqHhrjGCcJZZBwHRcspZsBsHRc
PFFpLFSpzVdSTPgnzzdPPZBRcZBwBJRcWJBmJW
vdTTzVpNVpfCChMGqMvr
VtZzBzhtlrhznFlBfgrfZgFrPjGRMGjRTmSjRjRTHjfRHmRv
DQpnsbJCsNNnpNNJsDQdCDcRmHPGTHTHRSmRmHjvjHSpSS
cQbnQdNLdJJQJJJDJWnFwzgwBthrgZBwBgFLZV
VhRRgmhpFjFFBDVPGPWQPzvvMMWfjf
qcnbnCbfLqJrCnrcdbbLrGSlzWsQvsWWzvWGdMWGQl
bnfbwrcwCrHqnHcZhFBTBVRDFmpBHB
lrtqltJJJqSTWJqVHRnsRhphdbfbzBdhsRsd
vSZCgZMMLSNvCQLPLDPNgZgnznzBfsGGnQnQGdnsfhsfzb
CMFLgmPgFFNMFDDCgLLcrWrjTTjtmSJqlWTTwWSr
LdjljBdZMFdZFLLLgPvWzQRzCsCmCVssmFSW
TJttwDhnnTlWsQzSQQDvWm
HtcnfctJwtwrHhrwhfHhJpjNLMZBMgZLrBlbbLNPNj
qqhNchPdpqTTNqpDmmvvGzVfzfmvdH
cwccjsFwFjnwGwQDfVVVVv
FbWjcRsLLFngBrjpbJqCJZTbJZNClq
lhznMTSzSnjhQGtVPQBdGB
msfNDDJLWslJgfNgCrmLdtGQFVvdGQPZVttBFP
RCrJJJDrJRsfgmbsrNsrlDMTSMHcjqwzScjMqqTjbbSc
nNgsvNWDRvgnRNVCFddTNZTNZQCTFZ
lffHJfHSPmSfvLlbLmpZrCTFTtrTQHqtTrCCrq
cpzblplpbvMzWnsDDB
CgtvQvJvMtWttvwftCdWvDQrfsFcrqnlcnqZZFRcRqsnhF
HzLzVBNLjHqnhzFlWFlr
NmBjLbVVbmbTLpTjBNVLHNdCtTSWQvCgdwSwJtWQwdSD
lncHcnlccVSLNSQNslncLcrZJCrgPfJZDrggJCCvZPHC
jRqqRmmqFwRFppfPPppPBfpWBvZf
wmMqjtTdjFwGGdtNhQbVfhntcNLVbL
HFBgMjpbpddMpbHdgHLLRNwhwFLDtNSRDLLD
zsCnfqZflrlnhhrtwNgggNNL
CGqnQzlqlWWMWgVBGg
pQnvzjztpzpCmtzzjzpnBHrJNGlqggMMqgqlNWgfNNqNCP
sVTSwddRRDVShwRwRTWgPNqMGQMGNqMWslsg
hDSTQhcQcHrtcBmZHv
QRmQfvQpWpswfZWWvNbhlMglgFbZDldlbL
rzHqtcnqqVjqjGcHdLdFdCFdCbLDnMCh
DGcGGSPDpWTsSfpv
llfMHTmvHlfZlFZRzgQzsFBLtLzFGF
wrWNJrdJhRmhGmNh
DWrrJjwPjCdPDwdmwnrTZnZZcqZfnqbvZfHvql
mPmVJJmNZJmlVBPPrZpWcFWbGWbjgqNbdqjSjg
nMhzwRhwvhMDMgWHRdGHgccggd
sMvnhQshMwwvdvMMCwBtlZtplZpTmPBVZVlC
ltlRzpncRglplzhFwFwzZZMWLWZBqnDVZLDVZQQQ
SJcdvJscNSsGcSGCSJmsTQDTVZQTLTQQWCTTMQCW
sPdJmcvsJvGJmdJmfpwftfrlztrRlPfP
LdPrWcMCWCfPdMJgdFsbRRHsRSHRHHcFpH
hVVTQmQTnRFLFsmzps
qthVVwZqlQLQhNttDDDWrffDJJJDrgNP
BTjTNjtlPrBjjrljbnMFfhVWFFhlMWMfHdll
mzcgZvDggDDCJCZLvsLJLcmVqWVSVqFLfdHHMWVWWWffnF
cmmcmzQDZQJmZCnDRgQCTTwjpTtwRjrbNjpPpwrj
rMbchQphhCSbGnzSbl
qFtgvTTqFFFFJGzWJG
NZjGqGBNjNHQrhpPNHQr
LnLmbtTtTwtLcVfFFLtPrfPrfqqqsqhSvrhrhh
BzJWzZRZJzJvlZJCZgZZpJHCqQDhNQPDqDDrjNsjPPNrhSCN
lpJWZzJpgHWdWMgHlJMZzgpJLGVLGGvwVwtmcGbvGMGVvncn
WdBgdqRgWqHmNNwsGgcQ
ptPVbPbSbMJrmsVzRzhwmcGQ
SSbvrJbJtCDZfTqdRfCdBZ
WDNNWvPpvNJRRbGLsGMnnbmG
qgFdBwgVdjwdtjjdBgMgGmLQsnZrnZssGswsmLrw
FqTCTtqjdjVqgCqSMJMTvPThTJMNDh
brSSSpZjVVWdfVrHPhRBggNNGwHr
fDlLzFCLMvnMMJLNHNCBQwNhRgwRPP
MJqMmfzDvFtLDtmsVsZZTsSScWcsbq
CSZlllhSdnDrrDdJjqjzbSGzGvwbfHMb
gTNvVNLQtsFpQHqfwfBfVMfHzf
QgNmWTtmTcmmdmrZRvnlPl
SmzfvfjvjbjLNJjD
cFhWMhGHTPhccMQQGBTFGwbVVwdbddJDvVJLvDDHvd
GFMBGcWTWhcGrhFZTTchQsSfgtmnnRvnmnnRgRCrRS
ZTQHVZsZSQpQQGBMGqfBRbRB
CwtLDtNFcPnllwnqvMgbvGVfVfBG
VClLWWFPPhlhctsTrrSpWpmszjZj
HChzPltNnnHtnpqSpHpFpSfSvS
mJmQssZJLdTQLcbjlGLGfSgMbqwwSFSMSFMMqMwS
JdBLlGTjLjjjjdmmBPnRzCBRNPhPtPWPtr
FPLHMHqqPMgFLLggsMghTJhwtDSSJDltJvtwdvST
WQfmjQZsjfZNQCrZCNZQQWQBCSClvdwTSClwSwlTJvtwJdbT
BpmzrWcpBrfmpsGPGFqPRgzqVPLM
bHjccpHwGHJTfPlffPwr
VtChMZVhhStZdfTCfJvcPRCTJn
sLNLZcdNZZqZqqVqSNWtjQDGHssHGHgQHDBgmsDg
CdWgCpddwgClFlmmVTBbRtRtbntBVVds
vcJGhPLPhJvChLhMLfccrvfvsVVbsGBTTBnVbRzBVstsGnbz
vJJHhjcCLPPjQPHLrSZmpgmqwlWZZgZZQm
VpTFCFtrjCdJdjHVFnSjszSllDjsDzgvzl
fhmhZBMtfZfGBNfNcmsbZnzSlRsRggslsbnv
qPLPhMcLhPfNWPpFrdFdFTtJ
nlgQJhJFlncMzMWZMFvw
mDdsDfHjHsjHdjTLfpDsbDcNzzwcRbZNZPMcCPWMRPMc
sqqdwffHjTmdmpffmLddTTGDnSJtJBShVVhrGVJtShrlBBnJ
CrcMcMDBCmLlZdSd
qPjGjnQPqWjgZmTdlFwTmqLJ
bnPnnzHjbPznzVpdpVDcvprr
TCScMQcQCrssJPQhQs
VpfnqqfdVVwpqvqwGbDPPsjgPShDSsJhlnSl
qffdmGpfwfbfvVqpfwwfbdqRMTSTWNMWTmZLTzTCZTMLWC
QQPpPbPbDNplSJrCCj
VdMzffgnRmVdfVWRvlrCTjRlNBvrrlrr
mGgNdthhGgMWWtsFcHcHwqLqtH
HrPFVqVppVpDjFDrVbCpDFJSLsmwjhjGLLmthJLJLmZs
WWgRdMdRMnQnRzWvPSssPWssJmhsshtG
MnfvMlnQccvfMlcTRMQdRfpHPDDDpPrDTbTBNbHbHDCq
GWWRsSwLhWsRsSbsPttThZqrNBJJBgPNCJCCqNMNgP
HpVDTHzfFDpFfzHzFVcrBZCggMJBvNrNgcNNrM
jlVpVpVVQDHdFVlmmmQTlzpjjGstWLsSbsnnnStWLRhnht
prLMDDjNCLZbdFLGngdLBv
VQHmhWSSzhWHmPJRJhSmVHJPFvgTbtnTbBtGqbQnbdqgTFqG
RzwzzhwhwNCvvfpc
wQgmZnhmWVtwQmnnnQbQhzwsFcRPrFPvRJhPlPPBBBFvJv
DdjqMMGLLMMGqTGdMqdMLdBBJsJPJBJJrrBFcqRlPlqr
DsddsfMsWgfzftZb
lcqlFSFwBBPlNwPlvSlQfWsVLTQjzjWVfLsWVq
HMMbMHMtJHgFzzFrVVtfFQ
RMFpCDDFcCNBcZvP
gwDrClhppDDPwPhnmPlwDrlDjMFfMTjMTjJmRHHJBJRMJHGj
LbbZBSvSLVRHffHJHJGZ
WztdtLsSvNQStbbtzdStthWhnwnPBDclgwwnrwllCC
MnMMBppMBDWMhpnCDBgCBmRbstvPvvbGltSPVGlVPWVv
TrrddJHjNcTqrrqdFcqZwSvLSlGGPbtFRbLvFVSRPG
JTccqTcwNQcTJrZwNJcJqHwJBQDfhCBCpCQpmpDfMRfCfBpn
njVcjHfGjVjpTCpMWprW
tsSsQDvSqQshDhtmWpnQnmMmbrpdzM
FNhsDDLNLnNllBqfRJGBVHBPHRRBZZ
hFVdlFSFlfZdRhgWgdWnnnfGpMNfnLMQzQQjMD
RsrJRHsvBcvHBHjDMMpDQDjjzDHj
BcCmBqvrbbqJgmFZtWdRVSVV
FzzdDJrJCFSFRqLlwsgspsBCpL
HQdWhMZMVwqLMllw
bbQtcvZcmHtNPZcWthWRvrdrRzrSDfRSrzjJjR
bTFZzHjZNJHzLggsJgbdsWcdcShWCwsSSdvGvv
VDBmntntfCBGGGGhRc
fMnnPDfmDlmnMPmtmttnVlHzZzNLbFbLbhzJJjMgJFbb
GzgJGPRrMSgTgpgH
hcvWhBdhcfPFvmFQvwfbHMsMMbpDpTDSSHsHpd
LmcvFFlcWQlFlfPnRZPVCJzJClCz
DdCHCHrmHRgghTHH
pFVZFwfssMsgghML
tSnphvhtctSSQNDqNdmrWGvq
rqmtRmGmcWrRRQprRRnfbGMMlPGGPblwMbTP
BHHhVZSvDNdhvBVhshbzfPbTmDfnwPwzPgbl
ddvBsSSdsLdshLsLpmWqcWrCCrtFpQ
wZPCwdPCHrnLQCGZDcPRqllzqqBzjlqc
gMmgnJspsvTmWNVWNpTNWNcDcqVjqDcclhSzllRSDzqR
JnWsgMnngmttFWWMdrwCZwHfZfdfGdFd
wwgNgrsWvbfBrqqsWbjDCDDDCDCmFbSmLDLlSC
QdpdzQTVdzRMTVVzcHTQLnlFmZHPSChCmlDPPHnP
dRMLVttzzVtTVQVqrrrgBtsvWWwtNw
vtBvntlqMvfnTfPDPhdRNbhdTFzF
QLWcmrrcgmCgCcsgcQWlWWrrDjjzzjsdFDdRhPNDhhhzDzPF
GGWHcCQcCCSlmmBVMGVBfMqwJtqv
cfqfhDRwhqZgRgRzRvcfhBSrsBnrDBBJWrnrWrSmmr
VCTVjGCTCjFddQntmrsVsJvrtrrW
PFQGpFbvPRMNqgRq
MmDgZZGMjZGfZRFztzCtCjzSrF
cBNpPJpBdNntcBHBccJlsSVVzzSwlCRrCnzsFw
PPBJLPPBBLPHBNQgqfMQtmTftGGvhq
bbZnbnVVgVSnbgZtntZrltsprpMCJvpqdJmsCMMmvvCq
BjDcjLLDzNjLDcjDzhcDNLLLHdpmpHJsqsMMNfCHfJpspqvp
dFLTFBcBzjFLgTbQtRgTVTlZ
nqNnrBRjLnjLZCqGGlqSGWlWDS
mTJTTcTJJfJfhhhwMbQDPWCQFCRlbDCSDDPl
dhMcRgJmgRrBrrrNgrLZ
GvJvJSGZFrGmmbmCrWnhjncLctcWttVqjLBB
wDlTzwlHTncRTqnRBt
gspglgzDzdPDfpgfdDzsgMPGvZJBrrbZGJNFmCFvmFvFvM
RLjMZZzfvNLBdjQfBfQdhRfSTVlcVqGbGcLGlbmqLVccmm
FggHCwsggrWWtCHJDDHtWrTNNlqSnlTlnGVTmWGcbcbm
PtpttrwsJssPsdRQvphZNzdMBh
NqqpZBHqTBpPNpPpGwwMPGTJjjLjQljGmtLfftllbJQfGf
nHczcrSFnVWSlrltrgJmjLLQ
SvzcDDVVFzdzhndCFSvnhcDspRDRDMPpMHRNPPZqppwM
FRSbVCSFFCDMFjRMjSSVFSWggMmWtWngJWttWmmJctnt
BPwcQQcQqQmWHfgrfwrh
PPlBQdNQvdLzzvclczdNRSbpLSbRbDjFZFFZVsFs
wtrrVhBbpcZSSjBfSfmm
MDWTvTMGMRCDCTQWsvfrRjjFfHlFmjlmLlHl
gQrTQvQDssdNWGsTstcbptwVPqcbpNqttP
jtGSwGQczrzjtGzrcsJwMRqMVMwRVMWFvVTWFV
DhLgnDLndDHmLvWqpTHqHHVNqF
LhdmPhfgZnZDlPCPmDfljQtGsJtBsWjGJzJSWBjC
zHDjcjBjTfjjfGpf
NNFTnNwPNNdqnJdFnqqTgmgftfftrWCZGbmrpWttmW
FLJqVNVNhnwnTRsRQBlQzShs
HJGJGJzzHHQHfJHsnNsGMbccMrTgbr
vddSCCjdmVvDDmvmBVbbBchcrrcscMTTnscn
VjWdFCVVMWWmjdSVFSVpqwwZttfJJltJZqltppLw
SnmPBPBnMLnPBsSgSDqRNRRccDfNcNQQRg
lZVWtWVzCjvZzCCGzDwbwRwtqJwJNTtDfD
zCzHZFFFfdLnBfFf
NRBFpNNJgNbWbJLRpRbWNtNpZllCZdjjZfjPVljTVCZQltlV
sDqHmsHcDrwHhMDlfCQfVBjDPCTd
MnGGcqwhhsrchcmGpzRJSSGGJWJzbJBR
LBzjQQzcjWvHWLnVDdnHRffHDCVR
rmJSrPJJsbNZssGSPrFpddfGwDRRpVjVpCGdCp
mPsrmsNTrPNLTjQlWQhqLc
MSDFszbhbRRTRdwhtw
PWmCZCmZVvGqMcjmJRpdTTtdLpqwdlll
MWGmmCVHvMSBDSNbbHHS
mBwSBSfSPHZCLPZSWwfPppTndVpdVncFgcgPpP
rhQJjzQjrltJzGqCrGJTvgqRpnTgFgcFTVFqFR
QbhGMJrhzrhQGQCsjwMDNWBDSZBZwSBLmM
bQfDPgDQbQNGPgflWfvMZcRMMFmcvMfZ
BLqSssjnzpBwszqwzFCNMvzWvRvzCCZFvc
BpNpjnNHnSpssqLqrBLLHjdhTPPDgbggllldhTPdrrQh
CvCMqNWVVqqPvNvvChhhdSnFHwBdWwhfdS
gqTZGGjlmclrZjlmSndSDwfFhhDBHm
tRrZpgrcctbbltRpgtqCVJCvPsRvsvPCQPCLPz
dTjRdWDBRzvjfzTfvTJPtJttsSLqHsSQJw
hrJNmbnFNZrbhlCsqltqcQcQSQqwPL
pVNhFgZphZmjzvjGDJWzVJ
gWzQhCWbQnCCFgCJnFQnWCzwjrHjjHGTwHGrhLwjjjtStL
splcpqDNDqqcZqRlspwHbjVrjjHTrwSbtVNV
BpMslDqDmRDRsBRBJPPnbzCfvQgmCWJb
tRtgRQWCwlTglHZHTglCtTdbbfvhWpbSBbhWzzbfGpfhbb
cqZVMJmLqmNrsJMDbzGrGSvzGBhvvG
mmnJPMZcclFRdnQtCQ
QVQVqfFzVVQQrQwZsCTrBtTrccTtctcJRRjT
vNNPnvGbBtWBLvBf
mMHbfDfHdHGmnhDDqZFDzVSQzF
NNlTNFCRTrfllTZsPWSsFPfzJdVQVpDQVszQVtpbzJMVbJ
LNHjNHjmLLjNqvGgvVQJQDVLbDVDpdQQzQ
nqmqGHjwgHvgwGHjGgccNTSWrrlCZrFfPSFFCP
qWzCQqhPCHjHmqJhqvqmjRgSFMTFggMFTFVRVVTgTm
SptGsDlnGfnDLgTMTwgRFFFs
bBcntZdpGZZcctlGtDfnDnBCSWqJvQhqjqzjhJqJQCQWPd
SjZJrSSDShddqLvPqzzdwq
nTssfRpQQmQCHlPBBgGmwVGzwm
TWQsbCRQFHFWQRTpzRHRsRrMtDrjhjbtMbccrttJjJht
cCChVMwPPMHCPCCPrvJnntdTJSvTtdrSRt
FGfFDBhGGlfGGfWJWdbSRSnRNbTvdn
fGpGlDmBhflgfDFmmfFpcVzMzqZZzcCPQVZzqP
SmgtSjGPjppBjbqqWTCZDQTHHHTg
VsFfCzLvsMfzNfNRhVMslzlHqrWrQDQcqDqTrLWHcrWJJW
dsRdsNCvNMVpwPdnnGbbPb
DONE