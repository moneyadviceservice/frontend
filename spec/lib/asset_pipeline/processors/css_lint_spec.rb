require 'spec_helper'
require 'asset_pipeline/processors/css_lint'

module AssetPipeline
  module Processors
    describe CssLint do
      describe '#evaluate' do
        let(:context) { double }
        let(:locals) { double }

        subject { described_class.new('foo.erb') {} }

        before do
          allow(subject).to receive(:data).and_return(css)
        end

        context 'when css is valid' do
          let(:css) { "body { background: red; }" }

          it 'returns the css without modifications' do
            expect(subject.evaluate(context, locals)).to eq(css)
          end
        end

        context 'when css lint report errors' do
          let(:css) { "p { color: red !important; }" }
          let(:formatted_errors) { double }

          before do
            allow(subject).to receive(:format_errors).and_return(formatted_errors)
          end

          it 'modifies the context and raises and exception' do
            expect(context).to receive(:__LINE__=).with(formatted_errors)
            expect { subject.evaluate(context, locals) }.to raise_error(CssLint::CssLintError)
          end
        end

        context 'when css lint report warnings' do
          let(:css) { "p[name^='child'] {color:blue;}" }

          it 'returns the css without modifications' do
            expect(subject.evaluate(context, locals)).to eq(css)
          end
        end

        context 'when css contains ignore annotations' do
          let(:css) do
            "/* @codingStandardsIgnoreStart */
              /* line 123 sass comment */
              p { color: red !important; }
            /* @codingStandardsIgnoreEnd */"
          end

          it 'returns the css without modifications' do
            expect(subject.evaluate(context, locals)).to eq(css)
          end
        end
      end
    end
  end
end
