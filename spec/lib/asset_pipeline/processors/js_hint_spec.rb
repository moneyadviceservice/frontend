require 'spec_helper'
require 'asset_pipeline/processors/js_hint'

module AssetPipeline
  module Processors
    describe JsHint do
      describe '#evaluate' do
        let(:context) { double }
        let(:locals) { double }

        subject { described_class.new }

        before do
          allow_any_instance_of(described_class).to receive(:initialize)
          allow(subject).to receive(:data).and_return(javascript)
        end

        context 'when javascript is valid' do
          let(:javascript) { "var foo = 'bar';" }

          it 'returns the javascript without modifications' do
            expect(subject.evaluate(context, locals)).to eq(javascript)
          end
        end

        context 'when javascript is invalid' do
          let(:javascript) { "foo;" }
          let(:formatted_errors) { double }

          before do
            allow(subject).to receive(:format_errors).and_return(formatted_errors)
          end

          it 'raises an exception' do
            expect { subject.evaluate(context, locals) }.to raise_exception(JsHint::ErrorsFound)
          end
        end
      end
    end
  end
end
