# To change this template, choose Tools | Templates
# and open the template in the editor.

class OemrSession
  @brw
  @main_frame
  @secondary_frame
  @nav_frame
  def brw
    return @brw
  end
  def initialize(b)
    @brw = b
    ObjectSpace.define_finalizer(self, proc{@brw.close})
    nav()
    if b.url.include? "_tab.php"
      @main_frame='patient'
      @secondary_frame='messages'
      b.span(:id=>'butTab2').click
    else
      @main_frame='RTop'
    @secondary_frame='RBot'
    end
  end
  
  def main_window()
    @brw.frame(:name,@main_frame).wait_until_present
    @brw.frame(:name,@main_frame).locate
    main=@brw.frame(:name,@main_frame)
    return main
    
  end
  def nav()
    @brw.frame(:name,"left_nav").wait_until_present
    @brw.frame(:name,"left_nav").locate
    nav=@brw.frame(:name,"left_nav")
    return nav
  end

  def goto_nav(id)
      
      nav().link(:id=>id).click
  end
  def goto_search()
    goto_nav("new0")
    sleep 2
  end
  def goto_calendar()
    goto_nav("cal0")
  end
  
  def start_edit_problems()
    main_window().table(:id=>'patient_stats_issues').span(:text=>"Edit").click
    
  end
  
  def choose_diagnosis(diag)
    @brw.text_field(:name=>'form_diagnosis').click
    @brw.window(:url,/find_code_popup.php/).wait_until_present
    @brw.window(:url,/find_code_popup.php/).use
    @brw.text_field(:name=>'search_term').set(diag)
    @brw.button(:name=>'bn_search').click
    @brw.link(:index=>1).wait_until_present
    @brw.link(:index=>1).click
    @brw.windows[0].use
  end
  def add_problem(title,diagnoses)
    main_window().div(:id=>'patient_stats').span(:text=>'Add').click
    @brw.window(:url,/add_edit_issue.php/).use
    @brw.text_field(:name=>'form_title').set(title)
    diagnoses.each do |diag|
      choose_diagnosis(diag)
      @brw.window(:url,/add_edit_issue.php/).wait_until_present
      @brw.window(:url,/add_edit_issue.php/).use
      @brw.text_field(:name=>'form_title').click
    end
    @brw.window(:url,/add_edit_issue.php/).use
    @brw.button(:name=>"form_save").click
    @brw.windows[0].use
  end

  def add_problem_expired(title,diagnosis)
    main_window().div(:id=>'patient_stats').span(:text=>'Add').click
    @brw.window(:url,/add_edit_issue.php/).use
    @brw.text_field(:name=>'form_title').set(title)
    choose_diagnosis(diagnosis)
    @brw.window(:url,/add_edit_issue.php/).wait_until_present
    @brw.window(:url,/add_edit_issue.php/).use
    @brw.text_field(:name=>'form_title').click
    @brw.text_field(:name=>'form_end').set("2013-01-01")
    @brw.window(:url,/add_edit_issue.php/).use
    @brw.button(:name=>"form_save").click
    @brw.windows[0].use
  end

  
end
