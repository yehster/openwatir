require "./setupBrowser.rb"
require "./openemrTasks.rb"
require "./oemr_session.rb"
require "./patient_data.rb"

@brw=startBrowser()

oemrLogin(@brw,$server,'admin','pass')
@s=OemrSession.new @brw

require "./fee_sheet_tests.rb"
@fst=FeeSheetTests.new @s
@fst.setPatient (PatientData.new 1,"Male")
@fst.run
