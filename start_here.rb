class StartHere

  def read_input(file)
    file = File.read(file).each_line
    config = file.next.gsub('\n','')
    config_array = config.split(' ')
    @L = config_array[0].to_i
    @D = config_array[1].to_i
    @N = config_array[2].to_i
    @words = []
    test_cases = []
    for i in 0...@D
      @words[i] = file.next.gsub('\n','')[0,@L]
    end
    for i in 0...@N
      test_cases[i] = file.next.gsub("\n",'')
      test_cases[i] = test_cases[i][0,test_cases[i].length-2] if test_cases[i].include?("\n")
    end
    temp_test_cases = []
    j = 0
    test_cases.each do |test_case|
      temp_test_cases[j] = []
      if test_case.include?('(')
        for i in 0...@L
          temp_test_cases[j][i] = ''
          if i == 0 && test_case[temp_test_cases[j][i].length, test_case.size][0] == '('
            temp_test_cases[j][i] = test_cases[j][/\(.*?\)/]
          elsif test_case[temp_test_cases[j][0,i].join.length, test_case.size][0] == '('
            temp_test_cases[j][i] = test_case[temp_test_cases[j].join.length, test_cases[j].length]
            temp_test_cases[j][i] = temp_test_cases[j][i][/\(.*?\)/]
          else
            temp_test_cases[j][i] = test_case[temp_test_cases[j].join.length, test_cases[j].length].split('')[0]
          end
        end
      else
        temp_test_cases[j] = test_case.split('')
      end
      j = j + 1
    end
    @tests = temp_test_cases
  end

  def process_it
    @result = []
    for k in 0...@N
    @result[k] = 0
    end
    for i in 0...@D
      time = Time.now
      for k in 0...@N
        temp = true
        for j in 0...@L
          temp = false unless @tests[k][j].include?(@words[i].split('')[j])
        end
        @result[k] = @result[k] + 1 if temp == true
      end
      puts Time.now-time
    end
  end

  def write_output(file)
    file = File.open(file, 'w')
    for i in 0...@result.size
      file.puts('Case #' + (i+1).to_s + ': ' + @result[i].to_s)
    end
  end

  def process_it2
    @result = []
    for i in 0...@N
      @result[i] = 0
    end
    for i in 0...@N
      time = Time.now
      temp = @words
      for k in 0...@L
        temp = temp.select { |x| @tests[i][k].include?(x.split('')[k]) }
      end
      @result[i] = temp.count
      puts Time.now-time
    end
  end

  def run_it(input,output)
    time = Time.now
    read_input(input)
    puts Time.now-time
    #process_it
    process_it2
    puts Time.now-time
    write_output(output)
    puts Time.now-time
  end

  StartHere.new.run_it('A-large-practice.in','output')
end
