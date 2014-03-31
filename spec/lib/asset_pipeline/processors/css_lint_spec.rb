require 'spec_helper'
require 'asset_pipeline/processors/css_lint'

module AssetPipeline
  module Processors
    describe CssLint do
      describe '#evaluate' do
        let(:context) { double }
        let(:locals) { double }

        subject { described_class.new }

        before do
          allow_any_instance_of(described_class).to receive(:initialize)
          allow(subject).to receive(:data).and_return(css)
        end

        context 'when css is valid' do
          let(:css) { "body { background: red; }" }

          it 'returns the css without modifications' do
            expect(subject.evaluate(context, locals)).to eq(css)
          end
        end

        context 'when css is invalid' do
          let(:css) { "body { background: red " }
          let(:formatted_errors) { double }

          before do
            allow(subject).to receive(:format_errors).and_return(formatted_errors)
          end

          it 'modifies the context and raises and exception' do
            expect(context).to receive(:__LINE__=).with(formatted_errors)
            expect { subject.evaluate(context, locals) }.to raise_exception
          end
        end
      end
    end
  end
end
