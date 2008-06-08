require 'options'

describe Rawr::Options do


  BUILD_CONFIGURATION = <<-EOL
      # Name of the created jar file
      project_name: CopyCenter


      # Directory to create and place produced project files in
      output_dir: package

      # File to set as main-class in jar manifest
      main_java_file: org.rubyforge.rawr.Main

      # Ruby file to invoke when jar is started
      main_ruby_file: main

      # Location of Ruby source files
      ruby_source_dir: src

      ruby_library_dir: lib/ruby

      # Location of Java source files
      java_source_dir: src

      # Directories that should have ALL their .jar contents loaded on the classpath
      # If you wish to only include specific jars from a directory use classpath_files
      classpath_dirs:
         - lib/java

      # Individual files that should be loaded on the classpath
      classpath_files:
          - lib/java/gems.jar
          - lib/java/jrubygems-0.4-SNAPSHOT.jar
          - lib/java/jruby-complete.jar
          - lib/java/swing-layout-1.0.3.jar
          - lib/java/derby-10.3.2.1.jar
          - lib/java/jdbc_adapter_internal.jar
          - lib/java/monkeybars-0.6.2.jar
      # Directory that should be loaded onto the java.library.path 
      #native_library_dirs:
      #    - lib/native

      # Directories which you want the coentents of to be copied to the output directory
      package_data_dirs:
          - lib/java

      # Directories to be added into the jar
      #jar_data_dirs:
      #    - data
      #    - gem

      # NOT YET IMPLEMENTED
      #pre_processing_task:
      #post_processing_task:


      web_start: 
        self_sign: true
        self_sign_passphrase: password
        jnlp:
          vendor: HCS
          code_base: http://www.happycamperstudios.com/foo
          homepage_href: '/bar.html'
          description: 'The description' 
          offline_allowed: true
          shortcut_desktop:  true
          menu_submenu:  'Foo Bar'



   EOL
  it "parses jars: into JarBuilders" do
    jars_hash = {'jars' => {"test.jar" => {'dir' => 'test', 'glob' => '**/*_test.rb'}}}
    Rawr::Options.instance.load_jars_options(jars_hash)
    Rawr::Options[:jars]['test.jar'].should_not be_nil
  end

  it "adds jars into the classpath from jars: config node" do
    jars_hash = {'jars' => {"test.jar" => {'dir' => 'test', 'glob' => '**/*_test.rb'}}}
    Rawr::Options.instance.load_jars_options(jars_hash)
    Rawr::Options[:classpath].should include("test.jar")
  end


  it "returns information about web_start configuration when that key is present" do
    config = YAML.load(BUILD_CONFIGURATION )
    Rawr::Options.instance.process_configuration(config)
    Rawr::Options.instance[:web_start].should_not be nil   
    Rawr::Options.instance[:web_start][:self_sign].should == true   
    Rawr::Options.instance[:web_start][:self_sign_passphrase].should == 'password'   
  end

  it "returns information about JNLP values web_start key is present" do
    config = YAML.load(BUILD_CONFIGURATION )
    Rawr::Options.instance.process_configuration(config)
    Rawr::Options.instance[:web_start].should_not be nil   
    Rawr::Options.instance[:web_start][:jnlp][:vendor].should == 'HCS'   
    Rawr::Options.instance[:web_start][:jnlp][:code_base].should == 'http://www.happycamperstudios.com/foo'   
    Rawr::Options.instance[:web_start][:jnlp][:homepage_href].should == '/bar.html'   
    Rawr::Options.instance[:web_start][:jnlp][:description].should == 'The description'   
    Rawr::Options.instance[:web_start][:jnlp][:offline_allowed].should == true
    Rawr::Options.instance[:web_start][:jnlp][:shortcut_desktop].should == true
    Rawr::Options.instance[:web_start][:jnlp][:menu_submenu].should == 'Foo Bar'
  end


end