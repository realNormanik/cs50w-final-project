import { notFound } from "next/navigation";

import { BOOK_QUERY } from "client/query";
import AudioPlayer from "components/player";
import { apolloClient } from "client/client";
import BookPanel from "components/panel/book-panel";

export default async function Page({ params }) {
  const { id } = await params;
  const client = apolloClient(process.env.BOOK_AUTH);

  const { data, error } = await client.query({
    query: BOOK_QUERY,
    variables: { id }
  });

  if (error) {
    console.error("Error:", error);
    notFound();
  };

  const book = data?.books[0];

  if (!book || !id) {
    notFound();
  };

  return (
    <div className="u22">
      <BookPanel book={book} />
      <AudioPlayer />
    </div>
  );
};