import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import buildPlanMd from "../../docs/spots/BUILD_PLAN.md?raw";

const BuildPlan = () => {
  return (
    <main className="min-h-screen bg-background text-foreground">
      <article className="mx-auto max-w-4xl px-6 py-12">
        <ReactMarkdown
          remarkPlugins={[remarkGfm]}
          components={{
            h1: ({ children }) => (
              <h1 className="mb-2 text-4xl font-bold tracking-tight">{children}</h1>
            ),
            h2: ({ children }) => (
              <h2 className="mt-10 mb-4 border-b border-border pb-2 text-2xl font-semibold">
                {children}
              </h2>
            ),
            h3: ({ children }) => (
              <h3 className="mt-6 mb-2 text-xl font-semibold">{children}</h3>
            ),
            p: ({ children }) => (
              <p className="my-3 leading-relaxed text-muted-foreground">{children}</p>
            ),
            ul: ({ children }) => (
              <ul className="my-3 space-y-2 pl-2">{children}</ul>
            ),
            ol: ({ children }) => (
              <ol className="my-3 list-decimal space-y-2 pl-6">{children}</ol>
            ),
            li: ({ children }) => (
              <li className="leading-relaxed">{children}</li>
            ),
            input: ({ checked, ...rest }) => (
              <input
                type="checkbox"
                checked={!!checked}
                readOnly
                className="mr-2 h-4 w-4 accent-primary align-middle"
                {...rest}
              />
            ),
            code: ({ children }) => (
              <code className="rounded bg-muted px-1.5 py-0.5 font-mono text-sm">
                {children}
              </code>
            ),
            hr: () => <hr className="my-8 border-border" />,
            strong: ({ children }) => (
              <strong className="font-semibold text-foreground">{children}</strong>
            ),
          }}
        >
          {buildPlanMd}
        </ReactMarkdown>
      </article>
    </main>
  );
};

export default BuildPlan;
