require 'asset_pipeline/processors/css_lint'

module AssetPipeline
  module Processors
    RSpec.describe CssLint do
      describe '#evaluate' do
        let(:context) { double }
        let(:locals) { double }
        let(:pathname) { double(to_s: File.join(Rails.root, 'app', 'assets', 'stylesheets', 'foo.css')) }
        let(:context) { double(pathname: pathname) }

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
            "body {
               /* @lintingIgnoreBegin */
              display: unkown-property;
              /* @lintingIgnoreEnd */
              color: red;
            }"
          end

          it 'returns the css without modifications' do
            expect(subject.evaluate(context, locals)).to eq(css)
          end
        end

        context 'when the file is outside the assets directory' do
          let(:pathname) { double(to_s: File.join(Rails.root, 'vendor', 'assets', 'stylesheets', 'foo.css')) }
          let(:css) { "p { color: red !important; }"  }

          it 'does not lint the file' do
            expect(CsslintRuby).not_to receive(:run)
            subject.evaluate(context, locals)
          end

          it 'returns the data' do
            expect(subject.evaluate(context, locals)).to eql(css)
          end
        end
      end
    end
  end
end
