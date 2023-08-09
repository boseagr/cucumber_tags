# frozen_string_literal: true

module CucumberTags
  # search for tags and filter the files
  class TagsHelper
    attr_reader :filtered_feature

    def initialize(files, tags)
      @feature_files = files
      @tags = tags.strip.tr('\"', '').split(' and ')
      @filtered_feature = []
    end

    def required_tags
      @required_tags = @tags.filter { |x| x unless x.include? 'not' }
    end

    def not_allowed_tags
      @not_allowed_tags = @tags.filter { |x| x if x.include? 'not' }
    end

    def node_tags(node)
      node[:tags].map { |x| x[:name] }
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
    def filter_feature
      @feature_files.each do |file|
        find = false
        gherkin_document = Gherkin::Parser.new.parse(File.read(file))
        feature_tags = node_tags(gherkin_document[:feature])
        gherkin_document[:feature][:children].each do |child|
          next if child[:type] == :Background
          break if find

          tags = node_tags(child) + feature_tags
          next if not_allowed_tags.any? { |x| tags.include? x }

          if child[:type] == :ScenarioOutline
            child[:examples].each do |example|
              child_tags = node_tags(example) + tags
              next if not_allowed_tags.any? { |x| child_tags.include? x }

              next unless required_tags - child_tags == []

              find = true
              @filtered_feature << file
              break
            end
          elsif required_tags - tags == []
            @filtered_feature << file
            break
          end
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
  end
end
