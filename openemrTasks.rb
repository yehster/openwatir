# To change this template, choose Tools | Templates
# and open the template in the editor.

def oemrLogin(brw, site,user, pass)
brw.goto site
brw.frame(:name=>"Login").wait_until_present
frmLogin=brw.frame(:name=>"Login")
frmLogin.text_field(:name=> "authUser").set user
frmLogin.text_field(:name=> "clearPass").set pass
frmLogin.button(:value=> "Login").click
end

def populate_fields(target,data)
  data.each{|key,value|target.text_field(:name=>key).set value}
end

