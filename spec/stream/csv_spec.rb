require 'spec_helper'

describe SimpleFile::CSV do
  let(:file)    { File.open('./spec/fixtures/sample.csv') }
  let(:subject) { SimpleFile::CSV.new }

  describe 'has required attrs: col_sep, encoding, mapping' do
    it { expect(subject.col_sep).to_not  eq(nil) }
    it { expect(subject.encoding).to_not eq(nil) }
    it { expect(subject.mapping).to_not  eq(nil) }
  end

  describe 'file type' do
    it 'does not allow string' do
      subject.import('abc')
      expect(subject.errors.to_s).
        to eq('SimpleFile::CSV::NotFileTypeError')
    end

    it 'does not allow number' do
      subject.import(123)
      expect(subject.errors.to_s).
        to eq('SimpleFile::CSV::NotFileTypeError')
    end

    it 'should allow file' do
      subject.import(file)
      expect(subject.errors).to eq(nil)
    end
  end

  describe 'mapping' do
    it 'should use csv headers as default mapping' do
      subject.import(file)
      expect(subject.mapping.keys).to eq(subject.file.headers)
    end

    it 'should use csv headers if key missing from mapping' do
      tmp = Tempfile.new('test.csv')
      CSV.open(tmp.path, 'wb') do |csv|
        csv << %w[col1 col2 col3]
        csv << %w[1 2 3]
      end
      mapping = { 'col4': '4' }
      subject = SimpleFile::CSV.new(mapping: mapping)
      subject.import(File.open(tmp.path))
      tmp.flush
      tmp.close
      expect(subject.mapping.keys).
        to eq(%w[col1 col2 col3 col4])
    end
  end
end
