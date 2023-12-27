# frozen_string_literal: true

module MakeMenu
  # A column of text with a fixed with
  class TextColumn
    # @param [Integer] width Width of the column, in characters
    def initialize(width)
      @width = width
      @rows = []
      @row_index = 0
    end

    attr_reader :width

    attr_accessor :rows, :row_index

    # Add a block of text to the column. Each row will be padded to the column width
    # @param [String] text The text to add, may be multi-line
    def add(text)
      self.rows += text.split("\n").map do |row|
        row.gsub("\r", '')
      end
      self.row_index += text.lines.size
    end

    # Return the specified row of text
    # @param [Integer] index The index of the row
    # @return [String] The row at the specified index
    def row(index)
      (rows[index] || '').align(width: width)
    end

    # @return [Integer] The number of rows in the column
    def height
      row_index
    end

    # @return [Boolean] True if the column is empty
    def empty?
      row_index.zero?
    end
  end
end