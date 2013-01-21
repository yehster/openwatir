class FeeSheetTests
  @os
  @patient
  def initialize(os)
    @os=os
  end

  def run
    @os.goto_search
    find_or_create_patient(@os,@patient.fields,@patient.sex)
  end
  def setPatient(pat)
    @patient=pat
  end
end
