$female_names=Array["Sophia","Emma","Isabella","Olivia","Ava","Lily","Chloe","Madison","Emily","Abigail","Addison","Mia","Madelyn","Ella","Hailey","Kaylee","Avery","Kaitlyn","Riley","Aubrey","Brooklyn","Peyton","Layla","Hannah","Charlotte","Bella","Natalie","Sarah","Grace","Amelia","Kylie","Arianna","Anna","Elizabeth","Sophie","Claire","Lila","Aaliyah","Gabriella","Elise","Lillian","Samantha","Makayla","Audrey","Alyssa","Ellie","Alexis","Isabelle","Savannah","Evelyn","Leah","Keira","Allison","Maya","Lucy","Sydney","Taylor","Molly","Lauren","Harper","Scarlett","Brianna","Victoria","Liliana","Aria","Kayla","Annabelle","Gianna","Kennedy","Stella","Reagan","Julia","Bailey","Alexandra","Jordyn","Nora","Caroline","Mackenzie","Jasmine","Jocelyn","Kendall","Morgan","Nevaeh","Maria","Eva","Juliana","Abby","Alexa","Summer","Brooke","Penelope","Violet","Kate","Hadley","Ashlyn","Sadie","Paige","Katherine","Sienna","Piper"]
$male_names=Array["Aiden","Jackson","Mason","Liam","Jacob","Jayden","Ethan","Noah","Lucas","Logan","Caleb","Caden","Jack","Ryan","Connor","Michael","Elijah","Brayden","Benjamin","Nicholas","Alexander","William","Matthew","James","Landon","Nathan","Dylan","Evan","Luke","Andrew","Gabriel","Gavin","Joshua","Owen","Daniel","Carter","Tyler","Cameron","Christian","Wyatt","Henry","Eli","Joseph","Max","Isaac","Samuel","Anthony","Grayson","Zachary","David","Christopher","John","Isaiah","Levi","Jonathan","Oliver","Chase","Cooper","Tristan","Colton","Austin","Colin","Charlie","Dominic","Parker","Hunter","Thomas","Alex","Ian","Jordan","Cole","Julian","Aaron","Carson","Miles","Blake","Brody","Adam","Sebastian","Adrian","Nolan","Sean","Riley","Bentley","Xavier","Hayden","Jeremiah","Jason","Jake","Asher","Micah","Jace","Brandon","Josiah","Hudson","Nathaniel","Bryson","Ryder","Justin","Bryce"]
$last_names=Array["Smith","Johnson","Williams","Brown","Jones","Miller","Davis","Garcia","Rodriguez","Wilson","Martinez","Anderson","Taylor","Thomas","Hernandez","Moore","Martin","Jackson","Thompson","White","Lopez","Lee","Gonzalez","Harris","Clark","Lewis","Robinson","Walker","Perez","Hall","Young","Allen","Sanchez","Wright","King","Scott","Green","Baker","Adams","Nelson","Hill","Ramirez","Campbell","Mitchell","Roberts","Carter","Phillips","Evans","Turner","Torres","Parker","Collins","Edwards","Stewart","Flores","Morris","Nguyen","Murphy","Rivera","Cook","Rogers","Morgan","Peterson","Cooper","Reed","Bailey","Bell","Gomez","Kelly","Howard","Ward","Cox","Diaz","Richardson","Wood","Watson","Brooks","Bennett","Gray","James","Reyes","Cruz","Hughes","Price","Myers","Long","Foster","Sanders","Ross","Morales","Powell","Sullivan","Russell","Ortiz","Jenkins","Gutierrez","Perry","Butler","Barnes","Fisher"]
class PatientData
  @fields
  @sex
  def initialize(num,sex)
    if(sex=="Male")
      fname=$male_names[num]
    else
      fname=$female_names[num]
    end
    $dob="1975-01-01"
    @fields={"form_lname"=>$last_names[num],
              "form_fname"=>fname,
              "form_DOB"=>$dob}
    @sex=sex
  end
  def fields
    @fields
  end
  def sex
    @sex
  end
end

def find_or_create_patient(os,data,sex)
  fill_patient_form(os,data,sex)
  row_found = false
  row_to_click = false
  if(os.brw.div(:id=>"searchResults").table[1].exists?)
    os.brw.div(:id=>"searchResults").table.rows.each do |row|
      begin
        if(row.cells[1].text=~/#{data["form_lname"]}, #{data["form_fname"]}/)
          if(row.cells[3].text=~/#{data["form_DOB"]}/)
            if(row.cells[4].text=~/#{sex}/)
              row_found=true
              row_to_click=row
            end
          end
        end
      rescue=>e
        
      end
    end
  end

  if(row_found)
    row_to_click.click
  else
  os.brw.button.click   
  end
  sleep 3
  os.brw.windows[0].use

end

def find_or_create_numeric_patient(os,num,sex)
  pat=PatientData.new(num,sex)
  find_or_create_patient(os,pat.fields,pat.sex)
end

def fill_patient_form(os,data,sex)
  os.goto_search
  populate_fields(os.main_window(),data)
  os.main_window().select_list(:id=>"form_sex").select sex
  os.main_window().button(:id=>"create").click
    os.brw.window(:url=>/new_search_popup.php/).use
  end

def create_patient(os,data,sex)

  fill_patient_form(os,data,sex)
  os.brw.button.click
  
  sleep 3
  os.brw.windows[0].use
end

def clear_patient_data(con,pid)
  con.query 'DELETE lists where pid='+pid
  con.query 'DELETE issue_encounter where pid='+pid
  con.query 'DELETE billing where pid='+pid
end