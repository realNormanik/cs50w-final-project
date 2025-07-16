export default function BookPanel({ book }) {
  const chapters = book.file ? book.file.split(",").map((url, index) => ({
    number: index + 1,
    url: url.trim()
  })) : [];

  return (
    <div className="u19 w-full p-7 order-2 md:roder-1">
      <h1>{book.title}</h1>
      <hr />
      <h2>Author: {book.author}</h2>
      <p>{book.description}</p>
      <h2>Chapters:</h2>
      <div className="h-25 grid overflow-y-auto overflow-x-hidden">
        {chapters.length > 0 ? (
          chapters.map((chapter) => (
            <li key={chapter.number}>
              Chapter {chapter.number}
            </li>
          ))
        ) : (
          <li>No chapters available.</li>
        )}
      </div>
    </div>
  );
};