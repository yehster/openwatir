class FeeSheetTests
  @os
  @patient
  def initialize(os)
    @os=os
  end

  def create_problems
    @os.goto_search
    find_or_create_patient(@os,@patient.fields,@patient.sex)
    @os.start_edit_problems
    @os.add_problem("DUPE 1",["V01"]);
    @os.add_problem("DUPE 2",["V01"]);
    @os.add_problem("Double ",["E001","E002"]);
    @os.add_problem("Double Dupe",["E003","E003"]);
  end
  def setPatient(pat)
    @patient=pat
  end
end
