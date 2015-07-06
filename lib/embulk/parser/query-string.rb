module Embulk
  module Parser

    class QueryString < ParserPlugin
      Plugin.register_parser("query-string", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          "property1" => config.param("property1", :string),
          "property2" => config.param("property2", :integer, default: 0),
        }

        columns = [
          Column.new(0, "example", :string),
          Column.new(1, "column", :long),
          Column.new(2, "name", :double),
        ]

        yield(task, columns)
      end

      def init
        # initialization code:
        @property1 = task["property1"]
        @property2 = task["property2"]
      end

      def run(file_input)
        while file = file_input.next_file
          file.each do |buffer|
            # parsering code
            record = ["col1", 2, 3.0]
            page_builder.add(record)
          end
        end
        page_builder.finish
      end
    end

  end
end
