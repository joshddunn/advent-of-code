init:
	mkdir ./$(year)/$(day)
	cp ./template/* ./$(year)/$(day)

	mkdir ./spec/$(year)/$(day)
	cp ./spec_template/* ./spec/$(year)/$(day)

	sed -i "" "s/YEAR/$(year)/" spec/$(year)/$(day)/solution_spec.rb
	sed -i "" "s/DAY/$(day)/" spec/$(year)/$(day)/solution_spec.rb
