curl 'https://jgiquality.qualer.com/Sop/SaveSopFile' \
  -H 'accept: */*' \
  -H 'content-type: multipart/form-data' \
  -H 'origin: https://jgiquality.qualer.com' \
  -H 'referer: https://jgiquality.qualer.com/Sop/Sop?sopId=2351' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36' \
  --form "documents=@'Form 3018, Rockwell 12-19-2024.xlsm';type=application/vnd.ms-excel.sheet.macroEnabled.12" \
  --form "sopId=2351" \
  --form "__RequestVerificationToken=dV0wiAYDKLjUO2frTVqKc6th7tnYcnbNIv4eiYsdqekfqjCC_4eSFieq_TX2wLxQ7JEtq9-r2sKvYncTxu-wb1qeKihRZ5hg5fnp0KZVsWpm9Bxs0"
  -F 'file=@Downloads/Form 3018, Rockwell.xlsm'

