#http://ajaxmin.codeplex.com/
AJAXMIN:='C:\Program Files (x86)\Microsoft\Microsoft Ajax Minifier\ajaxmin.exe'

# Define the list of full files
BUILD_FILES := $(addprefix build/, upcoming.js upcoming_no_moment.js upcoming.css index.html)
BUILD_FILES += $(addprefix build/min/, upcoming.js upcoming_no_moment.js upcoming.css index.html)

# the javascript packaged into the full, final product
JS_PARTS := $(addprefix src/, moment.js upcoming.js)

# the javascript if you include moment.js separately
JS_NO_MOMENT_PARTS := $(addprefix src/, upcoming.js)

# the CSS
CSS_PARTS := $(addprefix src/, upcoming.css)

# Default target
all : buildirs $(BUILD_FILES)

.PHONY : buildirs

buildirs : 
	mkdir -p build\min
	
build/upcoming.css : $(CSS_PARTS)
	$(AJAXMIN) $^ -o build\upcoming.css -clobber -pretty

build/upcoming.js : $(JS_PARTS)
	$(AJAXMIN) $^ -o build\upcoming.js -clobber -pretty	

build/upcoming_no_moment.js : $(JS_NO_MOMENT_PARTS)
	$(AJAXMIN) $^ -o build\upcoming_no_moment.js -clobber -pretty	
	
build/index.html : src/index.html
	cp $^ build
	
build/min/upcoming.css : $(CSS_PARTS)
	$(AJAXMIN) $^ -o build\min\upcoming.css -clobber

build/min/upcoming.js : $(JS_PARTS)
	$(AJAXMIN) $^ -o build\min\upcoming.js -clobber	

build/min/upcoming_no_moment.js : $(JS_NO_MOMENT_PARTS)
	$(AJAXMIN) $^ -o build\min\upcoming_no_moment.js -clobber	
	
build/min/index.html : src/min.html
	cp $^ build

.PHONY : clean
clean :
	-rm -r build