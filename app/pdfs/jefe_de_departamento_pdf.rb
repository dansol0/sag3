class JefeDeDepartamentoPdf < Prawn::Document

 
 def initialize(user1,user2, user3, user4, user5, view)
	  super(:margin => [15,15,15,15])
	  @user1 = user1
	  @user2 = user2
	  @user3 = user3
	  @user4 = user4
	  @user5 = user5
	   @view = view
	  #bounding_box([8, cursor - 8],:width => 565,:height => 745) do
		  logo
			move_down 25
		  header ''
			move_down 30
		  body    
			move_down 220	                  
		 # footer
		 # transparent(0.5){ stroke_bounds }
		#end
	    
	end

  def logo
    logopath =  "#{Rails.root}/app/assets/images/logo_pdf.jpg"
    image logopath, :width => 197, :height => 91
    move_down 10
  end

  def header (title=nil)
  	 text "LISTA DE JEFES DE DEPARTAMENTO DEL IDEC", size: 15, style: :bold, align: :center
    move_down 30
    bounding_box([25, cursor - 0], :width => 180, :height => 30) do
    	move_down 10
    	span(500,:position =>:center)do
	    	
	    	text "Fecha de emisión: " + " " + Date.today.strftime("%d/%m/%Y"), :size => 10, style: :bold
		end
		transparent(0.5) { stroke_bounds }

    end
 

    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end

  def body
  		
		  table(item_header, :cell_style => { :size => 8}, :width => 560,  :position => :center) do
 				cells.padding = 4
				row(0).font_style= :bold
				row(0).size = 9
				columns(0..1).borders = [:right, :top, :left, :bottom]
				row_colors =["F0F0F0","FFFFFF"]
				self.row_colors = ["F0F0F0","FFFFFF"]
				
				column(0).width = 200
				column(1).width = 360
				
				
				

				
			end

 end

 def item_header

 	[
 		["DEPARTAMENTO", "INVESTIGADOR DEL IDEC"],
 		["Departamento de Investigación:", "#{@user1.nombre1.upcase} #{@user1.apellido1.upcase}"],
 		["Departamento de Docencia:", "#{@user2.nombre1.upcase} #{@user2.apellido1.upcase}"],
 		["Departamento de Extensión:", "#{@user3.nombre1.upcase} #{@user3.apellido1.upcase}"],
 		["Departamento de Estación Experimental:", "#{@user4.nombre1.upcase} #{@user4.apellido1.upcase}"],
 		["Departamento de Asistencia Administrativa:", "#{@user5.nombre1.upcase} #{@user5.apellido1.upcase}"]
 	]


 end

 

 
		  

  def footer
    text "© 2015 IDEC, Instituto de Desarrollo Experimental de la Construcción.", size: 8, style: :bold_italic, align: :center
  end
   


end