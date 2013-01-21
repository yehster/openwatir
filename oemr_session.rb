# To change this template, choose Tools | Templates
# and open the template in the editor.

class OemrSession
  @brw
  @main_frame
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
      b.span(:id=>'butTab2').click
    else
      @main_frame='RTop'
    end
  end
  
  def main_window()
    @brw.frame(:name,@main_frame).wait_until_present
    main=@brw.frame(:name,@main_frame)
    return main
    
  end
  def nav()
    @brw.frame(:name,"left_nav").wait_until_present
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
  
end
