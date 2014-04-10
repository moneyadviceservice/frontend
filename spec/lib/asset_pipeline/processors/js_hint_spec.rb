require 'spec_helper'
require 'asset_pipeline/processors/js_hint'

module AssetPipeline
  module Processors
    describe JsHint do
      describe '#evaluate' do
        let(:jshint_options) { { unused: true } }
        let(:context) { double(pathname: pathname) }
        let(:locals) { double }

        subject { described_class.new('foo.erb') {} }

        before do
          allow(subject).to receive(:data).and_return(javascript)
        end

        context 'when the file is inside the assets directory' do
          before do
            allow(subject).to receive(:options).and_return(jshint_options)
          end

          let(:pathname) { double(to_s: File.join(Rails.root, 'app', 'assets', 'javascripts', 'foo.js')) }

          context 'when javascript is valid' do
            let(:javascript) { "var foo = 'bar';\nprint(foo);" }

            it 'returns the javascript without modifications' do
              expect(subject.evaluate(context, locals)).to eq(javascript)
            end

            it 'returns the data' do
              expect(subject.evaluate(context, locals)).to eql(javascript)
            end
          end

          context 'when javascript is invalid' do
            let(:javascript) { "var foo = 'bar';" }
            let(:formatted_errors) { double }

            it 'raises an exception' do
              expect { subject.evaluate(context, locals) }.to raise_exception(JsHint::ErrorsFound)
            end
          end
        end

        context 'when the file is outside the assets directory' do
          let(:pathname) { double(to_s: File.join(Rails.root, 'vendor', 'assets', 'javascripts', 'foo.js')) }
          let(:javascript) { "var foo = 'bar';" }

          it 'does not lint the file' do
            expect(JshintRuby).not_to receive(:run)
            subject.evaluate(context, locals)
          end

          it 'returns the data' do
            expect(subject.evaluate(context, locals)).to eql(javascript)
          end
        end
      end
    end
  end
end
